Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AbO8v-00032P-CH
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 09:58:57 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AbO8u-0000AI-MW
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 09:58:56 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML patches against vanilla 2.6.0
References: <200312261905.48277.blaisorblade_spam@yahoo.it> <Pine.LNX.4.58.0312280851350.2434@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.58.0312280851350.2434@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312281720.44991.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 28 Dec 2003 17:20:44 +0100
To: user-mode-linux-devel@lists.sourceforge.net

> Thanks for the great pointer.
> I've downloaded all these patches and
> finally able to boot a clean 2.6.0-1um using initrd. There seems to some
> problem with network (tuntap), but I'm still looking it.

We'll accept happily reports.

> Here's what I did ...
>
> My real linux version is 2.4.24-pre1. My /usr/src/linux points to 2.6.0
> with reiser4 and Ingo Molnar's uml-combo-2.6.0-A5 patch applied ... in
> order for "make menconfig" to set CONFIG_PROC_MM=y
>
> Here's my patch against Ingo Molnar's uml-combo-2.6.0-A5 patch to make the
> patch works if you use reiser4 ...

Btw: avoid at all, if possible, patches in normal format; always use unified 
diff.
However, probably the patchset works with reiser4, for what I saw reviewing 
your diff. Was the error message something about do_mmap_pgoff, I guess?

> http://web.tiscali.it/no-redirect-tiscali/blaisorblade/linux/archives/UML/v
>2/
[...]
> Next, apply the following patches I created to make uml compiles ...
About these: most of them are needed because I did some silly errors, even 
because doing 4 kernel compiles(i386/uml, PROC_MM on and off)  to test it is 
a bit tiring... however now I did those test and finally it should be 
working.

In general, I'd suggest using 00-Combo-4.patch.bz2, which should remove the 
need for them, + remove the A-04... patch when you compile for i386.

Who has the modify_ldt problem (as Jeff Chua) should use also this piece(copy 
it from the previous email). However, I hope I can put a workaround for this 
problem in the next version of the patchset:

> --- uml/arch/um/sys-i386/bugs.c.org	Sat Dec 27 23:28:01 2003
> +++ uml/arch/um/sys-i386/bugs.c	Sat Dec 27 23:29:19 2003
> @@ -16,6 +16,9 @@
>
>  #define MAXTOKEN 64
>
> +extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
> +
> +
>  /* Set during early boot */
>  int host_has_cmov = 1;
>  int host_has_xmm = 0;
> @@ -107,7 +110,7 @@
>
>  static void disable_lcall(void)
>  {
> -	struct modify_ldt_ldt_s ldt;
> +	struct user_desc ldt;
>  	int err;
>
>  	bzero(&ldt, sizeof(ldt));

About this piece:
> --- uml/mm/mmap.c.org	Sun Dec 28 00:17:14 2003
> +++ uml/mm/mmap.c	Sun Dec 28 00:17:43 2003
> @@ -714,7 +714,7 @@
>  	return error;
>  }
>
> -EXPORT_SYMBOL(__do_mmap_pgoff);
> +EXPORT_SYMBOL(do_mmap_pgoff);
No, sorry, but the symbol to export is __do_mmap_pgoff, since I changed the 
function name.
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
