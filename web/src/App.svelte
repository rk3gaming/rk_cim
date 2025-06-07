<script lang="ts">
  import './app.css'
  import Cim from './lib/components/Cim.svelte'
  import { useNuiEvent } from './lib/utils/useNuiEvent';

  let visible = false;

  useNuiEvent('setVisible', (data: { show: boolean }) => {
    visible = data.show;
  });
</script>

{#if visible}
  <main>
    <Cim />
  </main>
{/if}

<style>
 
</style>
