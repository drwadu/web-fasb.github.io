import { defineStore } from 'pinia'

export const  useMovesStore =  defineStore('MovesStore', {
    state: () => {
        return {
            moves: [{id: 0, type: 'pf1', assumption: null, rule: { head: 'a', body: ['c', 'd'] }}]
        }
    }

    // actions
    // getters
})