import { createApp } from 'vue/dist/vue.esm-bundler';

document.addEventListener("DOMContentLoaded", () => {
  const form = createApp({
    data: function() {
      return {
        isDisplay0: true,
        isDisplay1: false,
        isDisplay2: false,
        isDisplay3: false,
        isDisplay4: false,
        isDisplay5: false,
        isDisplay6: false,
        isDisplay7: false,
        buttonState0: true,
        buttonState1: false,
        buttonState2: false,
        buttonState3: false,
        buttonState4: false,
        buttonState5: false,
        buttonState6: false,
        buttonState7: false,
      }
    },
    methods: {
      changeDisplay: function(isDisplay) {
        let isDisplays = ['isDisplay0', 'isDisplay1', 'isDisplay2', 'isDisplay3',
                          'isDisplay4', 'isDisplay5', 'isDisplay6', 'isDisplay7'];
        let index = isDisplays.indexOf(isDisplay);
        const _this = this;
        isDisplays.splice(index, 1)
        isDisplays.forEach(function (isDisplay) {
            _this[isDisplay] = false;
        });
        this[isDisplay] = true;
      },
      changeButton: function(buttonState) {
        let buttonStates = ['buttonState0', 'buttonState1', 'buttonState2', 'buttonState3',
                          'buttonState4', 'buttonState5', 'buttonState6', 'buttonState7'];
        let index = buttonStates.indexOf(buttonState);
        const _this = this;
        buttonStates.splice(index, 1)
        buttonStates.forEach(function (buttonState) {
          _this[buttonState] = false;
        });
        this[buttonState] = true;
      }
    }
  })
  form.mount("#form")  
});