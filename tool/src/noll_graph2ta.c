/**************************************************************************/
/*                                                                        */
/*  NOLL decision procedure                                               */
/*                                                                        */
/*  Copyright (C) 2013                                                    */
/*    LIAFA (University of Paris Diderot and CNRS)                        */
/*    VeriFIT (Brno University of Technology)                             */
/*                                                                        */
/*                                                                        */
/*  you can redistribute it and/or modify it under the terms of the GNU   */
/*  Lesser General Public License as published by the Free Software       */
/*  Foundation, version 3.                                                */
/*                                                                        */
/*  It is distributed in the hope that it will be useful,                 */
/*  but WITHOUT ANY WARRANTY; without even the implied warranty of        */
/*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         */
/*  GNU Lesser General Public License for more details.                   */
/*                                                                        */
/*  See the GNU Lesser General Public License version 3.                  */
/*  for more details (enclosed in the file LICENSE).                      */
/*                                                                        */
/**************************************************************************/

/**
 * Defines translation between heap graph to time automata
 */

#include "noll.h"
#include "noll_graph2ta.h"
#include "noll_vector.h"
#include "libvata_noll_iface.h"

/* ====================================================================== */
/* Data types */
/* ====================================================================== */

// a list of markings (associated to very node)
NOLL_VECTOR_DECLARE( noll_marking_list, noll_uid_array* )
NOLL_VECTOR_DEFINE( noll_marking_list, noll_uid_array* )

// mapping of nodes to lists of their markings
NOLL_VECTOR_DECLARE( noll_nodes_to_markings , noll_marking_list* )
NOLL_VECTOR_DEFINE( noll_nodes_to_markings , noll_marking_list* )

/* ====================================================================== */
/* Constants */
/* ====================================================================== */

const uid_t NOLL_MARKINGS_EPSILON = -1;

/* ====================================================================== */
/* Translators */
/* ====================================================================== */

/**
 *  Translates g into a tree automaton.
 *  @return TA built or NULL
 */
noll_ta_t* noll_graph2ta(noll_graph_t* g) {
	// check sanity of input parameters
	assert(NULL != g);
	assert(NULL != g->lvars);
	assert(NULL != g->svars);
	assert(NULL != g->var2node);
	assert(NULL != g->edges);

	NOLL_DEBUG("g = %p\n", g);
	NOLL_DEBUG("number of nodes in g = %d\n", g->nodes_size);
	NOLL_DEBUG("LVars:\n");
	for (size_t i = 0; i < noll_vector_size(g->lvars); ++i)
	{
		NOLL_DEBUG("  (*g->lvars)[%lu] = %p, ", i, noll_vector_at(g->lvars, i));
		const noll_var_t* var = noll_vector_at(g->lvars, i);
		assert(NULL != var);
		NOLL_DEBUG("name = %s, vid = %u, ", var->vname, var->vid);
		NOLL_DEBUG("points to node -> %u\n", g->var2node[i]);
	}
	NOLL_DEBUG("SVars:\n");
	for (size_t i = 0; i < noll_vector_size(g->svars); ++i)
	{
		NOLL_DEBUG("  (*g->svars)[%lu] = %p, ", i, noll_vector_at(g->svars, i));
		const noll_var_t* var = noll_vector_at(g->svars, i);
		assert(NULL != var);
		NOLL_DEBUG("name = %s, vid = %u, \n", var->vname, var->vid);
	}
	NOLL_DEBUG("Edges:\n");
	for (size_t i = 0; i < noll_vector_size(g->edges); ++i) {
		NOLL_DEBUG("  (*g->edges)[%lu] = %p, ", i, noll_vector_at(g->edges, i));
		const noll_edge_t* edge = noll_vector_at(g->edges, i);
		assert(NULL != edge);
		NOLL_DEBUG("from = %u, to = %u, id = %u, kind = %u, label = %u\n",
			noll_vector_at(edge->args, 0),
			noll_vector_at(edge->args, 1),
			edge->id,
			edge->kind,
			edge->label);
	}

	// Now, we compute for every node 'n' a set of markings 'pi(n)'. These is a
	// least fix point computation.

	// first, let's prepare a map of nodes to their markings, nodes are labelled
	// from 0, so let that be a vector

	assert(0 < g->nodes_size);
	size_t num_nodes = g->nodes_size;
	noll_nodes_to_markings* markings = noll_nodes_to_markings_new();
	assert(NULL != markings);
	noll_nodes_to_markings_resize(markings, num_nodes); // resize should allocate enough mem
	for (size_t i = 0; i < noll_vector_size(markings); ++i)
	{	// we allocate empty markings for every node now
		NOLL_DEBUG("Allocating marking for node %lu\n", i);
		noll_vector_at(markings, i) = noll_marking_list_new();
		assert(NULL != noll_vector_at(markings, i));
	}

	NOLL_DEBUG("Computing marking of nodes of the graph\n");

	// initialize the marking of the initial node to be 'epsilon'
	assert(0 < noll_vector_size(markings));
	assert(NULL != noll_vector_at(markings, 0));
	noll_uid_array* epsilon_marking = noll_uid_array_new();
	assert(NULL != epsilon_marking);
	noll_uid_array_push(epsilon_marking, NOLL_MARKINGS_EPSILON);
	noll_marking_list_push(noll_vector_at(markings, 0), epsilon_marking);

	// TODO: consider other initial node that the one with number 0
	NOLL_DEBUG("WARNING: we assume the index of the initial node of the graph is 0\n");

	bool changed = true;
	while (changed)
	{	// until we reach a fixed point
		changed = false;

		for (size_t i = 0; i < noll_vector_size(g->edges); ++i)
		{	// go over all edges and update according to them
			const noll_edge_t* edge = noll_vector_at(g->edges, i);
			assert(NULL != edge);
			assert(2 == noll_vector_size(edge->args));
			NOLL_DEBUG("Processing edge (*g->edges)[%lu] = %p, ", i, edge);
			NOLL_DEBUG("from = %u, to = %u, id = %u, kind = %u, label = %u\n",
				noll_vector_at(edge->args, 0),
				noll_vector_at(edge->args, 1),
				edge->id,
				edge->kind,
				edge->label);

			// check that the nodes are in the correct range
			assert(noll_vector_at(edge->args, 0) < num_nodes);
			assert(noll_vector_at(edge->args, 1) < num_nodes);

			// get markings of the source and destination nodes
			const noll_marking_list* src_markings = noll_vector_at(markings,
				noll_vector_at(edge->args, 0));
			noll_marking_list* dst_markings = noll_vector_at(markings,
				noll_vector_at(edge->args, 1));
			for (size_t j = 0; j < noll_vector_size(src_markings); ++j)
			{
				noll_uid_array* new_marking = noll_uid_array_new();
				noll_uid_array_copy(new_marking, noll_vector_at(src_markings, j));
				noll_uid_array_push(new_marking, edge->label);

				bool found = false;
				for (size_t k = 0; k < noll_vector_size(dst_markings); ++k)
				{	// check whether the marking is not already there
					const noll_uid_array* dst_mark = noll_vector_at(dst_markings, k);
					assert(NULL != dst_mark);
					if (noll_uid_array_equal(new_marking, dst_mark))
					{
						found = true;
						break;
					}
				}

				if (!found)
				{
					changed = true;
					noll_marking_list_push(dst_markings, new_marking);
				}
				else
				{
					noll_uid_array_delete(new_marking);
				}
			}
		}
	}

	NOLL_DEBUG("Marking of nodes of the graph computed\n");
	NOLL_DEBUG("Markings:\n");

	// print the computed marking
	for (size_t i = 0; i < noll_vector_size(markings); ++i)
	{
		const noll_marking_list* list = noll_vector_at(markings, i);
		assert(NULL != list);
		NOLL_DEBUG("Node %lu: {", i);
		for (size_t j = 0; j < noll_vector_size(list); ++j)
		{
			const noll_uid_array* mark = noll_vector_at(list, j);
			NOLL_DEBUG("[");
			for (size_t k = 0; k < noll_vector_size(mark); ++k)
			{
				NOLL_DEBUG("%d, ", noll_vector_at(mark, k));
			}

			NOLL_DEBUG("], ");
		}
		NOLL_DEBUG("}\n");
	}

	// delete markings
	for (size_t i = 0; i < noll_vector_size(markings); ++i)
	{	// we allocate empty markings for every node now
		noll_marking_list* list = noll_vector_at(markings, i);
		assert(NULL != list);
		for (size_t j = 0; j < noll_vector_size(list); ++j)
		{
			noll_uid_array_delete(noll_vector_at(list, j));
		}
		noll_marking_list_delete(list);
	}
	noll_nodes_to_markings_delete(markings);



	NOLL_DEBUG("Generating the TA for the graph\n");

  vata_ta_t* ta = NULL;
  if ((ta = vata_create_ta()) == NULL)
  {
    return NULL;
  }

	for (size_t i = 0; i < noll_vector_size(g->edges); ++i) {
		NOLL_DEBUG("Processing edge (*g->edges)[%lu] = %p, ", i, noll_vector_at(g->edges, i));
		const noll_edge_t* edge = noll_vector_at(g->edges, i);
		assert(NULL != edge);
		NOLL_DEBUG("from = %u, to = %u, id = %u, kind = %u, label = %u, field name = %s\n",
			noll_vector_at(edge->args, 0),
			noll_vector_at(edge->args, 1),
			edge->id,
			edge->kind,
			edge->label,
			noll_field_name(edge->label));

		vata_symbol_t* symbol       = "symbol";
		assert(NOLL_EDGE_PTO == edge->kind);
		assert(2 == noll_vector_size(edge->args));
		vata_state_t children[] = {noll_vector_at(edge->args, 1)};
		vata_add_transition(ta, noll_vector_at(edge->args, 0), symbol, children, 1);
	}

	// TODO

	return ta;
}

