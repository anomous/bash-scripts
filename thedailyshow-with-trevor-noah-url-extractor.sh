#!/bin/bash

#===================================================================================================================================================================================================================================#

### 	SET FILE PERMISSIONS

chmod='755'


#===================================================================================================================================================================================================================================#

#=====================================================================================DIRECTORY PATH AND ABSOLUTE PATH FOR BASH SCRIPT==============================================================================================#

###		SPACERS

echo -en '\n'
echo -en '\n'
echo -en '\n'

#===================================================================================================================================================================================================================================#

###		Determine Relative Symbolic Link for source

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TARGET="$(readlink "$SOURCE")"
  if [[ $SOURCE == /* ]]; then
    SOURCE="$TARGET"
  else
    DIR="$( dirname "$SOURCE" )"
    SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path, where the symlink file was located.
  fi
done

###		Relative Symbolic Link resolving to Absolute Directory Path

RDIR="$( dirname "$SOURCE" )"
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

#===================================================================================================================================================================================================================================#

###		Change Directory into Source Directory Path

cd "$DIR"

#===================================================================================================================================================================================================================================#

### 	SCRIPT HEADER

echo '******************************************************************'
echo '                                                                 *'
echo ' TheDailyShow URL-Extractor Bash Script                          *'
echo ' Coded by ANOMOUS                                                *'
echo ' Anonymous Online Modifier of User Software                      *'
echo ' yasnobratstvo@openmailbox.org                                   *'
echo '                                                                 *'
echo '******************************************************************'

#===================================================================================================================================================================================================================================#

###		SPACER

echo -en '\n'

#===================================================================================================================================================================================================================================#

### 	TAG

echo "***************************************************************************************************************"
echo "                                                                                                              *";
echo "       db         888b      88    ,ad8888ba,    88b           d88    ,ad8888ba,    88        88   ad88888ba   *";
echo "      d88b        8888b     88   d8\"'    \`\"8b   888b         d888   d8\"'    \`\"8b   88        88  d8\"     \"8b  *";
echo "     d8'\`8b       88 \`8b    88  d8'        \`8b  88\`8b       d8'88  d8'        \`8b  88        88  Y8,          *";
echo "    d8'  \`8b      88  \`8b   88  88          88  88 \`8b     d8' 88  88          88  88        88  \`Y8aaaaa,    *";
echo "   d8YaaaaY8b     88   \`8b  88  88          88  88  \`8b   d8'  88  88          88  88        88    \`\"\"\"\"\"8b,  *";
echo "  d8\"\"\"\"\"\"\"\"8b    88    \`8b 88  Y8,        ,8P  88   \`8b d8'   88  Y8,        ,8P  88        88          \`8b  *";
echo " d8'        \`8b   88     \`8888   Y8a.    .a8P   88    \`888'    88   Y8a.    .a8P   Y8a.    .a8P  Y8a     a8P  *";
echo "d8'          \`8b  88      \`888    \`\"Y8888Y\"'    88     \`8'     88    \`\"Y8888Y\"'     \`\"Y8888Y\"'    \"Y88888P\"   *";
echo "                                                                                                              *";
echo "                                                                                                              *";
echo "***************************************************************************************************************"

#===================================================================================================================================================================================================================================#

### 	DATE OF TODAY WITH SPACINGS

# Remove hyphens in date output, by removing following hyphens in the following (date '+%b-%d--%Y') 

DATEOFTODAY="$(date '+%b-%d--%Y')"

echo -en '\n'
echo -en '\n'
echo -en '\n'
echo -en '\n'

#===================================================================================================================================================================================================================================#

#		SET INPUT PARAMETERS

source=$1


###		VARIABLE INPUT

if [ "$source" = "" ] ; then
  echo "Usage: $0 <source>"
  echo -en '\n'
  echo -en '\n'
  echo "  <source> is the URL to copy"
  echo -en '\n'
  echo -en '\n'
  echo "  Example: http://www.cc.com/full-episodes/q4l3vh/the-daily-show-with-trevor-noah-september-28--2015---kevin-hart-season--ep-21001"
  echo -en '\n'
  echo -en '\n'
  echo -en '\n'
  exit 1
fi

#===================================================================================================================================================================================================================================#

###		Episode title

echo -en '\n'
echo -en '\n'


EPISODE=`echo "$source" |sed 's/http:\/\/www.cc.com\/full-episodes\/[a-zA-Z0-9]*\///g'`

echo -en '\n'
echo -en '\n'

echo "$EPISODE"

echo -en '\n'
echo -en '\n'

#===================================================================================================================================================================================================================================#

###		PARAMETERS

FILE="$EPISODE"

HTML="Webpage.html"

UA="User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:42.0) Gecko/20100101 Firefox/42.0"

CACHE="Cache-Control: no-cache, no-age, private, must-revalidate"

PRAGMA="Pragma: no-cache"

KEEP_ALIVE="Connection: Keep-Alive"

ACCEPT="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"

#===================================================================================================================================================================================================================================#


###		Text Processing using sed

###		Remove blank lines
# sed 's/[[:space:]]*$//g'

###		Strip <> tag
# sed 's/<//g'|sed 's/>//g'

###		Strip spaces
# sed 's. ..g'

###		Strip quotations
# sed 's/[""]//g'

###		Strip tags
# sed 's.\t..g'

###		Remove blanks
# sed 's/[[:space:]]*$//g'

### 	One liner - Strip <> tags, strip spaces, strip quotations, strip tabs
# sed 's/<//g'|sed 's/>//g' |sed 's. ..g'|sed 's/[""]//g' |sed 's.\t..g'


#===================================================================================================================================================================================================================================#

###		cURL - Fetch HTML page

curl \
--globoff \
--location \
-H "$ACCEPT" \
-H "$CACHE" \
-H "$PRAGMA" \
-H "$KEEP_ALIVE" \
-H "$UA" \
--url "$source" \
> "$HTML"

###		cat HTML page into text processing using sed and grep afterwards print only first line

cat "$HTML" \
|sed 's/<//g'|sed 's/>//g' |sed 's. ..g'|sed 's/[""]//g' |sed 's.\t..g' \
|sed 's./div..g' \
|sed 's/id::/http:\/\/www.cc.com\/feeds\/mrss\/?uri=/g' \
|sed 's.divdata-widget=clipSharedata-contentUri=..g' \
|sed 's.class=mobileShareWidgetshare_wrap..g' \
|sed 's.ahref=javascript:void(0)class=share_text_buttonShareEpisode..g' \
|sed 's.divdata-widget=episodeSharedata-contentUri=..g' \
|sed 's.divdata-contentUri=..g' \
|sed 's.data-widget=episodeShare..g' \
|sed 's/fluxsShareWidget/\&device=Other\&acceptMethods=fms,hdn1,hds\&cdnOverride=akamai/g' \
|sed 's/::og::http:\/\/www.cc.com\/class=//g' \
|sed 's/class=episodeShareWidgetshare_wrap//g' \
|sed 's/class=mobileShareWidgetshare_wrap//g' \
|sed 's/::og::http:\/\/www.cc.com\/full-episodes\/[a-zA-Z0-9~#%&_+=,.?/-]\/[a-zA-Z0-9~#%&_+=,.?/-]//g' \
|grep 'https\?://www.cc.com\/feeds\/mrss\/?uri=mgid:arc:episode:comedycentral.com:[a-zA-Z0-9~#%&_+=,.?/-]\+' \
|sed 's/[[:space:]]*$//g' \
|head -n 1 \
|sed 's/::og::http:\/\/www.cc.com\/full-episodes\/[a-zA-Z0-9]*\/[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[0-9]*--[0-9]*---[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*-[0-9]*-[a-zA-Z0-9]*-[0-9]*//g' \
|sed 's/::og::http:\/\/www.cc.com\/full-episodes\/[a-zA-Z0-9]*\/[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[0-9]*--[0-9]*---[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*-[0-9]*-[a-zA-Z0-9]*-[0-9]*//g' \
|sed 's/::og::http:\/\/www.cc.com\/full-episodes\/[a-zA-Z0-9]*\/[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[0-9]*--[0-9]*---[a-zA-Z0-9]*-[a-zA-Z0-9]*--[a-zA-Z0-9]*-[a-zA-Z0-9]*-[0-9]*-[a-zA-Z0-9]*-[0-9]*//g' \
|sed 's/::og::http:\/\/www.cc.com\/full-episodes\/[a-zA-Z0-9]*\/[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[0-9]*--[0-9]*---[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*-[0-9]*-[a-zA-Z0-9]*-[0-9]*//g' \
|sed 's/[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[a-zA-Z]*-[0-9]*--[0-9]*---[a-zA-Z0-9]*-[a-zA-Z0-9]*-[a-zA-Z0-9]*-[0-9]*-[a-zA-Z0-9]*-[0-9]*//g' \
|grep 'https\?://www.cc.com\/feeds\/mrss\/?uri=mgid:arc:episode:comedycentral.com:[a-zA-Z0-9*]' \
> "$FILE"

#===================================================================================================================================================================================================================================#

###		SPACERS

echo -en '\n'
echo -en '\n'
echo -en '\n'


#===================================================================================================================================================================================================================================#

###		CAT - URL Generators

MEDIAFEEDS=`cat "$FILE"`

cat "$MEDIAFEEDS"

MEDIA_RSS_URLS="thedailyshow-"$EPISODE"-temp.xml"

CLEANED_MEDIA_RSS_URLS="thedailyshow-"$EPISODE".xml"

MEDIAFEEDS_URLS="thedailyshow-"$EPISODE".MediaGenerator.txt"

RTMPE_URLS="thedailyshow-"$EPISODE"-RTMPE.txt"

HTTP_URLS_0="thedailyshow-"$EPISODE"-videofeeds-temp.txt"

HTTP_URLS_1="thedailyshow-"$EPISODE"-videofeeds.txt"

#===================================================================================================================================================================================================================================#

###		cURL - Media RSS

xargs -n 1 curl -H "$ACCEPT" -H "$CACHE" -H "$PRAGMA" -H "$KEEP_ALIVE" -H "$UA" --url < "$FILE" > "$MEDIA_RSS_URLS"

#===================================================================================================================================================================================================================================#

###		Cleanup Media RSS URL's

cat "$MEDIA_RSS_URLS" \
|sed 's/<//g'|sed 's/>//g' |sed 's. ..g'|sed 's/[""]//g' |sed 's.\t..g' \
|sed 's/media:contenttype=text\/xmlmedium=videoduration=[0-9]*.[0-9]*//g' \
|sed 's/isDefault=trueurl=//g' \
|sed 's/?device={device}&amp;context=mgid:arc:episode:comedycentral.com:[a-zA-Z0-9~#%&_+=,.?/-]\+//g' \
|sed 's/?device={device}&amp;suppressRegisterBeacon=true\///g' \
|grep 'https\?://media-utils.mtvnservices.com\/services\/MediaGenerator\/mgid:arc:episode:comedycentral.com:[a-zA-Z0-9~#%&_+=,.?/-]\+' \
>"$CLEANED_MEDIA_RSS_URLS"

#===================================================================================================================================================================================================================================#

###		cURL - MediaFeeds Generator

xargs -n 1 curl -H "$ACCEPT" -H "$CACHE" -H "$PRAGMA" -H "$KEEP_ALIVE" -H "$UA" --url < "$CLEANED_MEDIA_RSS_URLS" > "$MEDIAFEEDS_URLS"

#===================================================================================================================================================================================================================================#

###		CAT - Video Source Generator


# HTTP_BASE_PATH: http://viacommtvstrmfs.fplive.net/gsp.comedystor/com/

# RTMPE_BASE_PATH: rtmpe://viacomccstrmfs.fplive.net/viacomccstrm/gsp.comedystor/com/


###		Best Quality - 3500kbps


#	Extract RTMPE-URLS


cat "$MEDIAFEEDS_URLS" |sed 's/<//g' |sed 's/>//g' |sed 's.\t..g' |sed 's. ..g' |sed 's.src..g' |sed 's/.mp4\//.mp4/g' |grep 'rtmpe\?://[a-zA-Z0-9~#%&_+=,.?/-]\+h32'.mp4 > "$RTMPE_URLS"


#	Regex RTMPE-URLS to HTTP-URLS


cat "$RTMPE_URLS" |sed 's/rtmpe:\/\/[a-z0-9]*.[a-z0-9]*.[a-z]*\/viacomccstrm\/gsp.comedystor\/com/http:\/\/viacommtvstrmfs.fplive.net\/gsp.comedystor\/com/g' > "$HTTP_URLS_0"


#===================================================================================================================================================================================================================================#

###		SPACERS

echo -en '\n'
echo -en '\n'
echo -en '\n'
echo -en '\n'
echo -en '\n'

#===================================================================================================================================================================================================================================#

###		CAT HTTP URLS - Head first 4 lines

cat "$HTTP_URLS_0" | head -n 4

cat "$HTTP_URLS_0" | head -n 4 > "$HTTP_URLS_1"

#===================================================================================================================================================================================================================================#

###		CLEANUP

rm "$HTML"

rm "$FILE"

rm "$MEDIA_RSS_URLS"

rm "$CLEANED_MEDIA_RSS_URLS"

rm "$MEDIAFEEDS_URLS"

rm "$RTMPE_URLS"

rm "$HTTP_URLS_0"

#===================================================================================================================================================================================================================================#

###		SPACERS

echo -en '\n'
echo -en '\n'

#===================================================================================================================================================================================================================================#

###																									PRINT BATCH FILE - CONCAT


#===================================================================================================================================================================================================================================#

###		ECHO - Concat Batch File

BATCH_CONCAT=`
echo "@echo off"
echo -en '\n'
echo "color 1f"
echo -en '\n'
echo "title ffmpeg concat prompt"
echo -en '\n'
echo "cls"
echo -en '\n'
echo "set path="%~dp0""
echo -en '\n'
echo "echo("
echo "echo("
echo "echo("
echo "echo("
echo -en '\n'
echo ":INPUT"
echo -en '\n'
echo "set /p "INPUT=ENTER DATE FOR INPUT ["$EPISODE"]: ""
echo "if "%INPUT%"=="" goto INITIALIZE"
echo "if "%INPUT%"==" " goto INITIALIZE"
echo -en '\n'
echo "echo("
echo "echo("
echo "echo("
echo -en '\n'
echo ":INITIALIZE"
echo -en '\n'
echo "set "%input%=""
echo -en '\n'
echo "echo on"
echo -en '\n'
echo "ffmpeg.exe -f concat -i "%INPUT%".txt -c copy -bsf:a aac_adtstoasc "The.Daily.Show-"%INPUT%".720p.3500k.mp4" -map_metadata "The.Daily.Show-"%INPUT%".720p.3500k.mp4"[,metadata]:"%INPUT%",[metadata]"`

#===================================================================================================================================================================================================================================#

###		APPENDTO - Concat Batch File

ECHO_BATCH_FILE_TITLE=`echo The.Daily.Show-"$EPISODE"`

echo "$BATCH_CONCAT" >> "$ECHO_BATCH_FILE_TITLE.txt"

#===================================================================================================================================================================================================================================#

###		Flip (Line Endings)

flip -bm "$ECHO_BATCH_FILE_TITLE.txt"

#===================================================================================================================================================================================================================================#

###		Text File (.txt) to Batch File (.bat)

mv --no-clobber --no-target-directory "$ECHO_BATCH_FILE_TITLE.txt" "$ECHO_BATCH_FILE_TITLE.bat"

#===================================================================================================================================================================================================================================#

###		List Videofiles

cat "$HTTP_URLS_1" |sed 's/http:\/\/viacommtvstrmfs.fplive.net\/gsp.comedystor\/com\/dailyshow\/TDS\/Season_[0-9]*\/[0-9]*\///g' |head -n 4 > "$ECHO_BATCH_FILE_TITLE.txt"

#===================================================================================================================================================================================================================================#


###		SPACERS

echo -en '\n'
echo -en '\n'

#===================================================================================================================================================================================================================================#
