Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FAByD-0000py-Pb for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 12:12:49 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FAByC-0006RB-5m
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 12:12:49 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060217201405.GA2404@ccure.user-mode-linux.org>
References: <Pine.LNX.4.64.0602170009160.4626@sparrow>
	<20060217165635.GA5712@ccure.user-mode-linux.org>
	<Pine.LNX.4.64.0602171226260.4178@sparrow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602171226260.4178@sparrow>
Subject: [uml-devel] Re: 2.6.16-rc2 x86_64; Jeff's uml patch tar doesn't apply
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
Date: Fri, 17 Feb 2006 15:14:05 -0500
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Feb 17, 2006 at 12:29:58PM -0500, William Stearns wrote:
> >I submit to you that perhaps your tree is not quite the cleanest
> >2.6.15-rc2 :-)
> 
> 	Ummm, 2.6._16_-rc2, I expect you meant.

Correct, but that was still a true statement :-)

> 	I opened up the linux-2.6.16-rc2.tar.bz2 direct from 
> ftp.kernel.org, used apply-quit-patches 
> ( http://www.stearns.org/apply-quilt-patches/apply-quilt-patches ) from 
> the patches directory, and got those errors.

Well, you show me yours and I'll show you mine.  Here's mine...

~/linux/2.6/test 7876: wget http://www.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.16-rc2.tar.bz2
--15:08:27--  http://www.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.16-rc2.tar.bz2
           => `linux-2.6.16-rc2.tar.bz2'
Resolving www.kernel.org... 204.152.191.5, 204.152.191.37
Connecting to www.kernel.org|204.152.191.5|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 40,817,609 (39M) [application/x-bzip2]

100%[====================================>] 40,817,609   627.97K/s    ETA 00:00

15:09:33 (610.73 KB/s) - `linux-2.6.16-rc2.tar.bz2' saved [40817609/40817609]

~/linux/2.6/test 7877: wget http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.16-rc2/patches.tar
--15:09:36--  http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.16-rc2/patches.tar
           => `patches.tar'
Resolving user-mode-linux.sourceforge.net... 66.35.250.209
Connecting to user-mode-linux.sourceforge.net|66.35.250.209|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 737,280 (720K) [application/x-tar]

100%[====================================>] 737,280        8.01K/s    ETA 00:00

15:10:21 (16.05 KB/s) - `patches.tar' saved [737280/737280]

~/linux/2.6/test 7880: bzcat linux-2.6.16-rc2.tar.bz2 | tar xf -
~/linux/2.6/test 7881: cd linux-2.6.16-rc2/
~/linux/2.6/test/linux-2.6.16-rc2 7882: tar xf ../patches.tar 
~/linux/2.6/test/linux-2.6.16-rc2 7883: mv patches/ x
~/linux/2.6/test/linux-2.6.16-rc2 7884: quilt setup /dev/null
~/linux/2.6/test/linux-2.6.16-rc2 7885: export dir=x; for p in `cat $dir/series`; do [ ! -f $dir/$p ] && continue; quilt import $dir/$p; quilt push || break; done
Importing patch x/uaccess-warning (stored as patches/uaccess-warning)
Applying patch patches/uaccess-warning
patching file arch/um/include/skas/uaccess-skas.h
patching file arch/um/include/tt/uaccess-tt.h
patching file arch/um/include/um_uaccess.h
patching file arch/um/kernel/skas/uaccess.c
patching file arch/um/kernel/tt/uaccess.c
patching file include/asm-um/uaccess.h

...

With lots of happiness following, except for the aforementioned offsets.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
