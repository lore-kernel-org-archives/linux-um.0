Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfJsv-0007OF-01	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 08:51:29 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DfJss-0000vU-FG	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 08:51:28 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Problems applying patches to 2.6.12-rc5-mm2
References: <OJEEKGNKKDLJIEPBEJMIMEKPCAAA.Anthony.Brock@oregonstate.edu>
In-Reply-To: <OJEEKGNKKDLJIEPBEJMIMEKPCAAA.Anthony.Brock@oregonstate.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506051754.41226.blaisorblade@yahoo.it>
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
Date: Sun, 5 Jun 2005 17:54:40 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Anthony Brock <Anthony.Brock@oregonstate.edu>

On Friday 03 June 2005 19:15, Anthony Brock wrote:
> In the event that something "wierd" happened to my guest binary, I've
> decide to try recompiling again. However, I'm now seeing new (and old)
> compilation errors with Jeff's tree. The steps were:

> # tar -jxvf linux-2.6.12-rc5.tar.bz2
> # cd linux-2.6.12-rc5/
> # bzip2 -dc ../2.6.12-rc5-mm2.bz2 |patch -p1
> # tar -xvf ../2.6.12-rc5-mm2-20050602-patches.tar
> # quilt push -a
> # cp -a ../.config .
> # make oldconfig ARCH=um
> # make ARCH=um && make modules ARCH=um
>
> <*** OUTPUT SNIPPED ***>
>
>   CC      arch/um/sys-i386/sigcontext.o
>   AS      arch/um/sys-i386/stub.o
>   CC      arch/um/sys-i386/stub_segv.o
> fixdep: arch/um/sys-i386/.stub_segv.o.d: No such file or directory
Ok, the other time I just looked at patch changelogs, now here's a more 
definite answer. The patch does not work because the .d file is not created.

Probably it works for you, Jeff, because you have that file as a residual from 
a previous compile...

In this section of the patch (both for i386 and x86_64), affecting 
arch/um/sys-*/Makefile, the last line:

+# _cflags works with kernel files, not with userspace ones, but c_flags does,
+# why ask why?
+$(obj)/stub_segv.o : c_flags = $(call unprofile,$(USER_CFLAGS))

should become (without the break):
+$(obj)/stub_segv.o : c_flags = -Wp,-MD,$(depfile) $(call unprofile,
$(USER_CFLAGS))

See for comparison the content of arch/um/scripts/Makefile.rules (and for the 
difference between _c_flags and c_flags, scripts/Makefile.lib).

Beyond that, for such tricks with .S files we would use a_flags (or 
_a_flags)... currently this is not needed, but just in case you need it.


> make[1]: *** [arch/um/sys-i386/stub_segv.o] Error 2
> make: *** [arch/um/sys-i386] Error 2

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
