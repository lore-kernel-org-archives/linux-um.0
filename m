Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYCoX-0007Fe-IA
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 15:16:45 -0800
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYCoX-0005sP-7M
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 15:16:45 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] 2.4.22-[67] problems
Message-ID: <20031221231638.GR9354@alcor.net>
References: <20031220011323.GW18100@alcor.net> <20031220171450.GB10692@ccure.user-mode-linux.org> <20031221004742.GE9354@alcor.net> <200312211658.44353.blaisorblade_spam@yahoo.it> <20031221224001.GO9354@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221224001.GO9354@alcor.net>
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
Date: Sun, 21 Dec 2003 15:16:38 -0800
To: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org, 224502@bugs.debian.org
Cc: debian-glibc@lists.debian.org

On Sun, Dec 21, 2003 at 02:40:01PM -0800, Matt Zimmerman wrote:

> I have heard reports that building the same source on Debian woody (glibc
> 2.2.5-11.5 with 2.4 kernel headers) works, however.  I am going to be
> testing this myself shortly.  If it works, the cause is most likely
> somewhere in glibc.

I have just verified this myself.  Building user-mode-linux 2.4.22-7um-1 on
woody works fine (even when running on unstable), but building it on
unstable does not.  The one built on unstable randomly sees ENOSYS from
certain system calls, such as select, read and mmap.

I would appreciate any suggestions for how to track this problem down
further.  I suspect that changes in glibc/linux-kernel-headers have broken
things.  I tried replacing the headers in linux-kernel-headers (asm,
asm-generic and linux) with the ones from Linux 2.4.22, but this did not
help.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
