<script context="module" lang="ts">
	export const prerender = true;
</script>

<script lang="ts">
	import { onMount, createEventDispatcher } from 'svelte';
	import { EmojiButton } from '@joeattardi/emoji-button';
	import { SmileIcon } from 'svelte-feather-icons';
	import Tags from 'svelte-tags-input';
	import type Channel from 'src/model/Channel';

	import type { Backdrop } from 'src/model/Backdrop';
	import { addToast } from '../stores/toaststore';

	const dispatch = createEventDispatcher();
	export let channel: Channel = {
		name: '',
		description: '',
		url: '',
		image: '',
		tags: []
	};
	export let selectedBackdrop: Backdrop;
	let emoji;
	let picker;

	export const handleSubmit = (channel: Channel) => {
		channel.emoji = emoji;
		if (channel.name.trim().length === 0) {
			addToast({ dismissible: false, message: 'Please add a name', type: 'error', timeout: 3000 });
			return
		}
		if (channel.url.trim().length === 0) {
			addToast({ dismissible: false, message: 'Please add a valid URL', type: 'error', timeout: 3000 });
			return
		}
		dispatch('submit', {
			channel: channel
		});
	};

	const handleTags = (event: any) => {
		channel.tags = event.detail.tags;
	};

	onMount(() => {
		picker = new EmojiButton({
			zIndex: 10000
		});
		picker.on('emoji', (selection) => {
			emoji = selection.emoji;
		});
	});
</script>

<div class="flex flex-row items-end justify-between mb-4 mt-2 z-50">
	<div class="flex flex-col flex-grow items-start mr-6">
		<label for="url" class="font-medium ">URL</label>
		<input
			bind:value={channel.url}
			required
			name="url"
			type="url"
			placeholder="Paste the link here"
			class="bg-white {selectedBackdrop.darkMode
				? 'bg-opacity-10'
				: 'bg-opacity-90'} rounded p-2 w-full"
		/>
	</div>
	<div
		id="emoji-trigger"
		on:click={() => {
			picker.togglePicker(document.querySelector('#emoji-trigger'));
		}}
		class="cursor-pointer rounded-lg w-14 h-14 bg-white flex items-center justify-center text-2xl {selectedBackdrop.darkMode
			? 'bg-opacity-10'
			: 'bg-opacity-90'}  transition duration-200 ease-in-out hover:scale-105"
	>
		{#if channel.image}
			<img src={channel.image} class="w-8 h-8" alt={channel.name} />
		{:else if emoji}
			{emoji}
		{:else}
			<SmileIcon size="26" strokeWidth="2" />
		{/if}
	</div>
</div>
<div class="flex flex-col items-start flex-1">
	<label for="name" class="font-medium ">Name it</label>
	<input
		bind:value={channel.name}
		required
		name="name"
		type="text"
		maxlength="30"
		placeholder="Type a name"
		class="bg-white {selectedBackdrop.darkMode
			? 'bg-opacity-10'
			: 'bg-opacity-90'}  rounded p-2 w-full"
	/>
</div>

<div class="my-4 flex  items-start flex-col">
	<label for="description" class="font-medium ">Describe it</label>
	<textarea
		bind:value={channel.description}
		name="description"
		type="text"
		rows="4"
		placeholder="Add an optional description"
		class="bg-white {selectedBackdrop.darkMode
			? 'bg-opacity-10'
			: 'bg-opacity-90'} rounded p-2 w-full"
	/>
</div>
<div class="my-4 flex items-start flex-col">
	<label for="tags" class="font-medium ">Tag it</label>
	<div class="tagsContainer w-full rounded-2">
		<Tags
			on:tags={(e) => {
				handleTags(e);
			}}
			bind:value={channel.tags}
			onlyUnique
			placeholder="Add tags"
		/>
	</div>
</div>
<div class="my-4 flex flex-row items-center cursor-pointer">
	<input name="homescreen" id="homescreen" type="checkbox" checked class="w-4 h-4 mr-3" />
	<label for="homescreen" class="cursor-pointer"> Add to my homescreen </label>
</div>
<div
	on:click={() => {
		handleSubmit(channel);
	}}
	class="flex mt-2 cursor-pointer justify-center items-center rounded font-medium py-2 text-lg {selectedBackdrop.darkMode
		? 'bg-white text-black'
		: 'bg-black text-white'} "
>
	Save
</div>

<style>
	.tagsContainer :global(.svelte-tags-input) {
		background: transparent;
		padding-top: 4px;
		padding-bottom: 4px;
		font-size: 16px;
	}
	.tagsContainer :global(.svelte-tags-input-tag) {
		border-radius: 3px;
		background: rgba(255, 255, 255, 0.1);
		font-size: 16px;
		padding: 4px;
	}

	.tagsContainer :global(.svelte-tags-input-tag-remove) {
		margin-left: 5px;
	}
	.tagsContainer :global(.svelte-tags-input-layout) {
		background-color: rgba(255, 255, 255, 0.1);
		border: none;
		outline: none;
	}

	.tagsContainer :global(.svelte-tags-input-layout:focus) {
		border: none;
	}
	.tagsContainer :global(.svelte-tags-input-layout:hover) {
		border: none;
	}
</style>
