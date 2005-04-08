Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJlkX-0004Rl-OJ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 22:09:45 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DJlkT-0002Lu-1A for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 22:09:45 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Broken compiling under 2.6.12-rc2 on my machine
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504072022.47474.blaisorblade@yahoo.it>
	<cbec11ac0504071621298678da@mail.gmail.com>
In-Reply-To: <cbec11ac0504071621298678da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IOhVCfuxd9iBn6n"
Message-Id: <200504080715.52655.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 8 Apr 2005 07:15:52 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Ian McDonald <imcdnzl@gmail.com>
Cc: Rob Landley <rob@landley.net>

--Boundary-00=_IOhVCfuxd9iBn6n
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 08 April 2005 01:21, Ian McDonald wrote:
> OK.
>
> Tested this change to arch/um/kernel/Makefile:
> cmd_quote2 = sed -e '/CONFIG/{'          \
>                  -e 's/"CONFIG"\;/""/'        \
>                  -e 'r $(obj)/config.tmp'     \
>                  -e 'a \'                   \
>                  -e '""\;'                  \
>                  -e '}'                       \
>                  $< > $@
>
> and can report that it fixes my problems.
>
> I can also report that vacopy patch works (which is also in 2.6.11.7 I
> notice but I haven't tested yet - I will post a note when I have but
> that may be next week) and syscall patch works (which is not yet in
> 2.6.11.x).
Test it from -bs3, please.
> Paolo I agree from my angle that this should go forwards as a confirmed
> patch.
Please make sure that the attached patch produces the same makefile as the 
manual change you did (yes, I'm a bit overzealous maybe, but copy and paste 
isn't perfect from mailers, patches are much better).

For me, I tested it on my Gentoo and produces the same output as the unpatched 
code.

Ah, Rob, I've re-read the code and re-understood pipes are not enough, and we 
must keep the temp step. Sorry (even if I blamed both, so I hope I've not 
been impolite).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_IOhVCfuxd9iBn6n
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-workaround-sed-behaviour.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="uml-workaround-sed-behaviour.patch"


From: Rob Landley <rob@landley.net>

It is apparent that the sed 3.02 (from august 1998) is still used on Debian Woody, and
it is stricter on input expressions for the "a" command. So change the code to
make it work - it's not a big change.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/Makefile~uml-workaround-sed-behaviour arch/um/kernel/Makefile
--- linux-2.6.11/arch/um/kernel/Makefile~uml-workaround-sed-behaviour	2005-04-08 07:00:07.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/kernel/Makefile	2005-04-08 07:05:40.000000000 +0200
@@ -53,6 +53,7 @@ quiet_cmd_quote2 = QUOTE   $@
       cmd_quote2 = sed -e '/CONFIG/{'          \
 		  -e 's/"CONFIG"\;/""/'        \
 		  -e 'r $(obj)/config.tmp'     \
-		  -e 'a""\;'                   \
+		  -e 'a \'                     \
+		  -e '""\;'                    \
 		  -e '}'                       \
 		  $< > $@
_

--Boundary-00=_IOhVCfuxd9iBn6n--




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
