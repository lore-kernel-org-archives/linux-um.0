Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfhBu-0000U5-90 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 07:07:50 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AfhBt-0000gS-OC for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 07:07:49 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML running on host-kernel 2.6.0 with NPTL-enabled
	glibc problem
References: <3FFE6FE3.8090303@vgertech.com>
	<200401102025.i0AKPXeA004382@car.linuxhacker.ru>
In-Reply-To: <200401102025.i0AKPXeA004382@car.linuxhacker.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401111149.20507.blaisorblade_spam@yahoo.it>
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
Date: Sun, 11 Jan 2004 11:49:20 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Oleg Drokin <green@linuxhacker.ru>, Nuno Silva <nuno.silva@vgertech.com>

Alle 21:25, sabato 10 gennaio 2004, Oleg Drokin ha scritto:
> Hello!
>
> Nuno Silva <nuno.silva@vgertech.com> wrote:
>
> NS> I've been trying for days and made lots of tests and it seems that the
> NS> 2.4 UML binary can't run on a host with 2.6 kernel and nptl-enabled
> glibc.
>
> Hm. I guess you are running some sort of old uml code.
> The fix was oneliner and included long ago. See the patch below.
> Apply it and then recompile.

I've just looked at 2.4.23-1um and I saw that dyn_link.ld.in has not this fix. 
Shouldn't it go in there, too? (That fix has been tested for both dynamic and 
static linking wrt 2.6 guest). Nuno, maybe you compiled a dynamic UML guest?

Note: the patch for dyn_link.ld.in must remove the first align, but not the 
second (this is for 2.6 so it won't apply, but it's good as reference):

--- ./arch/um/dyn.lds.S.align	2003-12-25 19:38:35.000000000 +0100
+++ ./arch/um/dyn.lds.S	2003-12-26 17:13:38.000000000 +0100
@@ -10,7 +10,6 @@
 {
   . = START + SIZEOF_HEADERS;
   .interp         : { *(.interp) }
-  . = ALIGN(4096);
   __binary_start = .;
   . = ALIGN(4096);             /* Init code and data */

-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
