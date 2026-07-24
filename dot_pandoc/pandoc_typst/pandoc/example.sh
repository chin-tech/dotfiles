# start script shell example
script_dir=$(
	cd "$(dirname "$0")" || exit
	pwd
)

# install themekit as typst local package first.
# see howto.themekit.pdf
template_dir="$script_dir/pandoc"
template="$template_dir/dark.ayu-dark.typst" # or others typst template in $script_dir/pandoc

markdwnfile=$1
output="${markdwnfile%.*}.pdf"

function usage {
	echo "usage: $0 markdown_file"
}

function check {
	markdown_dir=$(dirname "$markdwnfile")
	[ ! -d "$markdown_dir/themes" ] && {
		echo "No tmTheme. Before start, copy or link [$script_dir/themes] to your $markdwnfile directory [$markdown_dir]"
		echo "cp -R \"$script_dir/themes\" \"$markdown_dir\""
		echo "or "
		echo "ln -s \"$script_dir/themes\" \"$markdown_dir\""
		exit 1
	}
}

function pandoc_md2pdf {
	pandoc_args="--fram markdown_mmd+emoji+strikeout+fancy_lists+task_lists+implicit_figures+link_attributes+inline_notes+tex_math_single_backslash+simple_tables+grid_tables+multiline_tables+table_captions+yaml_metadata_block-blank_before_blockquote"
	[ ! -f "$markdwnfile" ] && {
		echo "\"$markdwnfile\" doesn't exists"
		usage
		exit 1
	}
	pandoc "$markdwnfile" $pandoc_args -t pdf --pdf-engine typst --template="$template" -o "$output"
}

check
pandoc_md2pdf
