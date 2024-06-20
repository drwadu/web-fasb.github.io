<template>
    <div id="terminal" ref="terminal" :class="{ 'is-focused': focused }" @click="(_) => this.$refs.terminalinput.focus()"
        @mousedown="onMouseDown" @mouseup="onMouseUp" @mousemove="onMouseMove">
        <div id="history" ref="history" v-html="commandOutput"></div>

        <div class="inputs">
            <span>{{ shellpropmt }}</span>
            <input id="terminal-input" ref="terminalinput" @keydown="onInputKeydown" v-model="inputCommand"
                @focusin="(_) => this.focused = true" @focusout="(_) => this.focused = false">
        </div>
    </div>
</template>

<style scoped>
#terminal {
    border: 1px solid white;
    padding: 10px;
    background-color: var(--color-background);


}

#terminal:hover {
    cursor: text;
}

.is-focused {
    box-shadow: 0 0 5px 2px lightblue;
}

#terminal-input {
    width: 100%;
    background-color: var(--color-background);
    color: var(--color);
    border: 0;
}

#terminal-input:focus {
    outline: none;
}


#history {
    height: 200px;
    width: 400px;
    overflow-y: auto;
    line-height: 0.8;
    background-color: var(--color-background);



}

.inputs {
    display: flex;
}
</style>

<script>
export default {
    // Properties returned from data() become reactive state
    // and will be exposed on `this`.
    data() {
        return {
            commandOutput: '',
            inputCommand: '',
            focused: false,
            shellpropmt: '>',
            terminal: null,
            // positioning
            offset: [15, 15],
            mouseDown: false
        }
    },

    // Methods are functions that mutate state and trigger updates.
    // They can be bound as event handlers in templates.


    methods: {
        increment() {
            this.count++
        },

        onInputKeydown(e) {
            if (e.keyCode == 13) {

                if (this.inputCommand == 'clear') { this.inputCommand = this.commandOutput = '' }
                else {
                    this.commandOutput += `${this.shellpropmt} ` + this.inputCommand + '</br>'
                    this.inputCommand = ''
                }

            }

            // hack, to always be scrolled maximally to the bottom
            setTimeout(this.scrollToBottom, 10)

        },

        focusTerminalInput(e) {

            this.$refs.terminalinput.focus();


        },

        scrollToBottom() {
            const scrollableDiv = this.$refs.history;
            if (scrollableDiv) {
                scrollableDiv.scrollTop = scrollableDiv.scrollHeight;
            }
        },

        onMouseDown(e) {
            // debugger

            console.log('mouse down')

            // debugger
            this.mouseDown = true
            console.log('mouse dow ' + this.mouseDown)

            this.offset = [
                terminal.offsetLeft - e.clientX,
                terminal.offsetTop - e.clientY
            ]
            console.log(this.offset)
        },

        onMouseUp(e) {
            console.log('mouse up')

            this.mouseDown = false
        },

        onMouseMove(e) {
            console.log('mouse move ' + this.mouseDown)

            if (this.mouseDown) {
                this.terminal.style.left = (e.clientX + this.offset[0]) + 'px';
                this.terminal.style.top = (e.clientY + this.offset[1]) + 'px';
            }

        }


    },


    mounted() {
        this.terminal = this.$refs.terminal

        // TODO:
        this.terminal.style.position = "absolute";
        this.terminal.style.left = `${window.innerWidth - 515}px`;
        this.terminal.style.top = `${window.innerHeight - 315}px`;
        // this.terminal.style.left = "15px";
        // this.terminal.style.top = "15px";




    }
}
</script>

