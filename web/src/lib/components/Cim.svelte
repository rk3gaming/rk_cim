<script lang="ts">
  import { fetchNui } from '../utils/fetchNui';
  
  let days = '';
  let description = '';

  function handleDaysInput(event: Event) {
    const input = event.target as HTMLInputElement;
    let value = parseInt(input.value);
    
    if (value > 30) value = 30;
    if (value < 1) value = 1;
    
    days = value.toString();
  }

  function handleClose() {
    fetchNui('close');
  }

  function handleCreate() {
    fetchNui('create', {
      days: parseInt(days),
      description: description
    });
  }
</script>

<div class="flex items-center justify-center min-h-screen">
  <div class="w-[620px] h-[620px] bg-gradient-to-br from-neutral-950 via-neutral-900 to-black relative rounded-lg shadow-lg">
    <div class="absolute top-6 left-6 right-6 flex flex-col">
      <div class="flex items-center gap-4">
        <div class="p-2.5 border border-white/20 rounded-lg bg-gradient-to-br from-neutral-950 via-neutral-900 to-black">
          <img src="./header.svg" alt="header icon" class="w-10 h-10" />
        </div>
        <div class="text-white flex flex-col justify-center gap-2">
          <h1 class="text-xl font-semibold leading-none">Create Information Marker</h1>
          <p class="text-sm text-white/60">You are creating a new information marker!</p>
        </div>
      </div>
      <button 
        class="absolute top-0 right-0 w-8 h-8 flex items-center justify-center hover:bg-neutral-800/80 hover:scale-110 active:scale-95 rounded transition-all duration-200"
        on:click={handleClose}
      >
        <img src="./close.svg" alt="close" class="w-5 h-5" />
      </button>
      <div class="h-px bg-white/10 mt-4 -mx-6"></div>
      <div class="mt-6 space-y-4">
        <div class="flex flex-col gap-2">
          <label for="days-input" class="text-sm text-white/60">Days</label>
          <input 
            id="days-input"
            type="number" 
            min="1"
            max="30"
            bind:value={days}
            on:input={handleDaysInput}
            class="w-full bg-neutral-900/50 border border-neutral-400/20 px-4 py-3 text-white text-sm focus:outline-none focus:border-neutral-400/40 transition-colors [appearance:textfield] [&::-webkit-outer-spin-button]:appearance-none [&::-webkit-inner-spin-button]:appearance-none" 
            placeholder="Enter days"
          />
          <p class="text-neutral-500 text-sm text-center">Please enter a number between 1 and 30 days. This will determine how long the marker will be active.</p>
        </div>
        <div class="flex flex-col gap-2">
          <label for="description-input" class="text-sm text-white/60">Description</label>
          <textarea 
            id="description-input"
            bind:value={description}
            class="w-full bg-neutral-900/50 border border-neutral-400/20 px-4 py-3 text-white text-sm focus:outline-none focus:border-neutral-400/40 transition-colors resize-none" 
            placeholder="Enter description"
            rows="8"
          ></textarea>
          <p class="text-neutral-500 text-sm text-center">You are creating an information marker to display long-term information such as signs, notices, or other important details</p>
        </div>
        <button 
          class="w-full bg-neutral-900 border border-neutral-400/20 text-white py-3 text-sm font-medium hover:bg-neutral-800 hover:border-neutral-400/40 hover:scale-[1.02] active:scale-[0.98] transition-all duration-200"
          on:click={handleCreate}
        >
          Create
        </button>
      </div>
    </div>
  </div>
</div>

<style>
</style>
