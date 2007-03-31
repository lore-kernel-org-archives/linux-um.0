Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXfdn-0001Qq-Df for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Mar 2007 08:37:19 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HXfdk-0004U1-FP
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Mar 2007 08:37:19 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 31 Mar 2007 17:37:05 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hAoDGpGnZZ2fgCg"
Message-Id: <200703311737.05784.blaisorblade@yahoo.it>
Subject: [uml-devel] [RFC] Auto-fixups for CodingStyle against major UML
	violations
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

--Boundary-00=_hAoDGpGnZZ2fgCg
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Have you got sick of fixing your sources CodingStyle by hand? Are you 
reintroducing violations because you've always programmed in a certain style 
and those kernel hacker have dictated an insane one which you'll never learn?

Stop that, the spamful company "BlaisorBlade Inc. " has the right solution for 
you, and this spam letter is going to explain ;-) !

Without using lindent, and with just a few sed/vim substitutions, it fixes 
most of the problems we keep having. I wrote most of it with vim, and I 
discovered it has another advantage: most of the substitutions also work on 
patches (well, not so straightforward, but anyway good).

Also, it calls quilt to create a patch for all this stuff, and can optionally 
do binary comparison to verify substitutions are safe (this is only coded, 
not tested).

The only exception is the one to move labels to the first column - a slightly 
different sub would be needed:

        sed -e 's/\<return\>(\(.*\))/return \1/' \
         -e 's/\<if\> \?(\(.*\)){/if (\1) {/'  \
         -e 's/\<if\>(\(.*\))/if (\1)/' \
         -e 's/\<for\> \?(\(.*\)){/for (\1) {/' \
         -e 's/\<for\>(\(.*\))/for (\1)/' \
         -e 's/\<while\> \?(\(.*\)){/while (\1) {/' \
         -e 's/\<while\>(\(.*\))/while (\1)/' \
         -e 's/^ \([a-z_]*:\)/\1/' \

This:
         -e 's/^ \([a-z_]*:\)/\1/'
would become this:
         -e 's/^\([ +-]\) \([a-z_]*:\)/\1\2/'

To yet test well:
- spaces to tabs (easy)
- binary comparison
Missing features:
- break if (foo) bar(); on two lines (probably won't do this one)
- do the work on patches
- have a sane cmd line interface (most of config is inside it).

Results: 
*) in less than 10 seconds (cache-hot) generates a 416k on arch/um and 
include/asm-um:

$ diffstat $(quilt top)|tail -n 1
 147 files changed, 2360 insertions(+), 2360 deletions(-)

*) doesn't clutter the source tree nor temp directories, if you have quilt 
installed.

I attach this with no guarantee at all, however! Bye!
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_hAoDGpGnZZ2fgCg
Content-Type: application/x-shellscript;
  name="do-src-style-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="do-src-style-fix"

#!/bin/bash

# Parameters - PATHS can be set as $1.
BUILD_PARAMS='ARCH=um'
#Paths where to act
PATHS="arch/um include/asm-um"
[ -n "$1" ] && PATHS="$1"
COMPILE_TEST=0
PATCH_NAME=style-fixes-auto
[ -d "$OUT" -a -z "$KBUILD_OUTPUT" ] && KBUILD_OUTPUT=$OUT

# Customize for your source manager. {{{
new_patch() {
	#Broken when the patch already exists.
	if ! quilt new $PATCH_NAME; then
		# A patch can be applied but still not exist, if it's empty or
		# it hasn't been refreshed.
		#if [ -f patches/$PATCH_NAME ]; then

		if ! grep $PATCH_NAME .pc/applied-patches; then
			quilt push $PATCH_NAME
		else
			quilt pop $PATCH_NAME || echo "quilt pop failed!" && exit 1
		fi
	fi
}

add_to_patch() {
	#Always works.
	quilt add "$1"
}

patch_refresh() {
	quilt refresh --strip-trailing-whitespace
}
# }}}

#Functions for compile diffing {{{
compile_file() {
	export KBUILD_OUTPUT
	name=$1
	if [ "${name#.c}" != "$name" ]; then
		obj=${name#.c}.o
		make $BUILD_PARAMS $obj
		unset prefix
		[ -n "$KBUILD_OUTPUT" ] && prefix=$KBUILD_OUTPUT/
		echo ${prefix}${obj}
	fi
}

save_compiled() {
	out=`compile_file $1`
	[ -n "$out" ] && mv -f $out $OUTFILE_CC
}

check_compiled() {
	out=`compile_file $1`
	if [ -n "$out" ]; then
		if !diff $out $OUTFILE_CC; then
			echo "Serious changes with $1 compiled to $out"
			exit 1
		fi
	fi
}
# }}}

#For script debugging.
DEBUG=0

TMP=~/tmp
[ -d $TMP ] || TMP=/tmp

#START 
new_patch

OUTFILE=`mktemp $TMP/tfile.XXXXXXXXXX`

[ -n $COMPILE_TEST ] && OUTFILE_CC=`mktemp $TMP/tfilecc.XXXXXXXXXX`

[ $DEBUG = 1 ] || cond_redir_to_null='> /dev/null'
find $PATHS -name '*.[ch]'| \
while read i; do
	sed -e 's/\<return\>(\(.*\))/return \1/' \
	 -e 's/\<if\> \?(\(.*\)){/if (\1) {/'  \
	 -e 's/\<if\>(\(.*\))/if (\1)/' \
	 -e 's/\<for\> \?(\(.*\)){/for (\1) {/' \
	 -e 's/\<for\>(\(.*\))/for (\1)/' \
	 -e 's/\<while\> \?(\(.*\)){/while (\1) {/' \
	 -e 's/\<while\>(\(.*\))/while (\1)/' \
	 -e 's/^\([\t]*\) \{8\}/\1\t/' \
	 -e 's/^\([\t]*\) \{8\}/\1\t/' \
	 -e 's/^\([\t]*\) \{8\}/\1\t/' \
	 -e 's/^\([\t]*\) \{8\}/\1\t/' \
	 -e 's/^\([\t]*\) \{8\}/\1\t/' \
	 -e 's/^\([\t]*\) \{8\}/\1\t/' \
	 -e 's/^\([\t]*\) \{8\}/\1\t/' \
	 -e 's/^\([\t]*\) \{8\}/\1\t/' \
	 -e 's/^\([\t]*\) \{8\}/\1\t/' \
	 -e 's/^\([\t]*\) \{8\}/\1\t/' \
	 -e 's/^\([\t]*\) \{8\}/\1\t/' \
	 -e 's/^ \([a-z_]*:\)/\1/' \
	< $i > $OUTFILE
	# The tab substitution is repeated to act on multiple initial tabs.
	# This would become, for patches:
	# -e 's/^\([ +-]\) \([a-z_]*:\)/\1\2/'

	if ! eval diff -u $i $OUTFILE $cond_redir_to_null; then
		save_compiled $i
		add_to_patch $i
		cat $OUTFILE > $i
		check_compiled $i
		[ $DEBUG = 1 ] && break
	fi
done
rm $OUTFILE
patch_refresh
# vim: set foldmethod=marker:

--Boundary-00=_hAoDGpGnZZ2fgCg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_hAoDGpGnZZ2fgCg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_hAoDGpGnZZ2fgCg--

