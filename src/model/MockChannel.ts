export default interface MockChannel {
	id?: string;
	title: string;
	url?: string;
	description?: string;
	defaultBoardPosition?: number;
	icon?: string;
	emoji?: string;
	iconImageUrl?: string;
	iconImageUrlDark?: string;
	draftIconImageUrl?: string;
	tags?: string[];
}

export const mockChannels = [
	{
		id: '1',
		emoji: '✉️',
		iconImageUrl: '../../../icons/vscode.svg',
		title: 'VSCode',
		defaultBoardPosition: 0,
		url: 'http://localhost:3000',
		tags: ['vscode']
	},
	{
		id: '2',
		emoji: '🗓',
		iconImageUrl: '../../../icons/rstudio.svg',
		title: 'Rstudio',
		defaultBoardPosition: 1,
		url: 'http://localhost:3000',
		tags: ['rstudio']
	},

	{
		id: '3',
		emoji: '💬',
		iconImageUrl: '../../../icons/terminal.svg',
		defaultBoardPosition: 2,
		title: 'Terminal',
		url: 'http://localhost:3000',
		description: 'Terminal'
	},
	{
		id: '4',
		emoji: '📓',
		iconImageUrl: '../../../icons/Filebrowser.svg',
		title: 'File Browser',
		url: 'http://localhost:3000',
		description: 'File Browser',
		tags: ['filebrowser']
	},
	{
		id: '5',
		emoji: '📬',
		iconImageUrl: '../../../icons/VNC.svg',
		title: 'VNC',
		url: 'http://localhost:3000',
		description: 'VNC',
		tags: ["vnc"]
	},
	{
		id: '6',
		emoji: '🖇',
		iconImageUrl: '../../../icons/Quilt.svg',
		title: 'Quilt',
		url: 'http://localhost:3000',
		description: 'Quilt',
		tags: ['quilt']
	},
	{
		id: '7',
		emoji: '📈',
		iconImageUrl: '../../../icons/mlflow.svg',
		title: 'Mlflow',
		url: 'http://localhost:3000',
		description: 'Mlflow',
		tags: ['mlflow']
	},
	{
		id: '8',
		emoji: '💸',
		iconImageUrl: '../../../icons/Ray.svg',
		title: 'Ray',
		url: 'http://localhost:3000',
		description: 'Ray',
		tags: ['ray']
	}
];
