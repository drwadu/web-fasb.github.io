<template>
    <div id="cytodiv" @click="addNode"></div>
</template>

<style scoped>
#cytodiv {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0px;
    left: 0px;
    background-color: white;
}
</style>

<script>
import cytoscape from 'cytoscape'

import { storeToRefs } from 'pinia'
import { useMovesStore } from '../stores/MovesStore'


export default {
    // Properties returned from data() become reactive state
    // and will be exposed on `this`.
    data() {
        return {
            moves: null,
            cy: null,
            initialId: 0,
            layoutConfig: {
                name: "circle",
                handleDisconnected: true,
                animate: true,
                avoidOverlap: true,
                infinite: false,
                unconstrIter: 1,
                userConstIter: 0,
                allConstIter: 1,
                ready: e => {
                    e.cy.fit()
                    e.cy.center()
                }
            }
        }
    },

    methods: {
        addNode() {
            debugger

            console.log('add node')
            this.cy.add([{
                group: 'nodes',
                data: { id: 75 },
                // position: { x: 200, y: 200 }
            }, {
                group: 'edges',
                data: {
                    id: '75-edge',
                    source: 75,
                    target: 'a'
                }
            }]);

            this.cy.makeLayout(this.layoutConfig).run()
        }

    },
    mounted() {

        // const movesStore = useMovesStore()

        const { moves } = storeToRefs(useMovesStore())
        this.moves = moves

        this.cy = cytoscape({
            container: document.getElementById('cytodiv'),
            elements: [
                // nodes
                { data: { id: 'a' } },
                { data: { id: 'b' } },
                { data: { id: 'c', parent: 'd' } },
                { data: { id: 'd' } },
                { data: { id: 'e' } },
                { data: { id: 'f' } },
                // edges
                {
                    data: {
                        id: 'ab',
                        source: 'a',
                        target: 'b'
                    }
                },
                {
                    data: {
                        id: 'cd',
                        source: 'c',
                        target: 'd'
                    }
                },
                {
                    data: {
                        id: 'ef',
                        source: 'e',
                        target: 'f'
                    }
                },
                {
                    data: {
                        id: 'ac',
                        source: 'a',
                        target: 'c'
                    }
                },
                {
                    data: {
                        id: 'be',
                        source: 'b',
                        target: 'e'
                    }
                }
            ],
            layout: {
                name: 'circle',
                directed: true
            },
            style: [
                {
                    selector: 'node',
                    style: {
                        shape: 'hexagon',
                        'background-color': 'red',
                        label: 'data(id)'
                    }
                }]
        });


    }
}
</script>

