import atob from 'atob';

// source https://stackoverflow.com/a/9786592
export default function(str: string): string {
	return decodeURIComponent(escape(atob(str)));
}
