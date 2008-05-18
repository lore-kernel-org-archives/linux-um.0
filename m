Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JxjS5-0001yP-20 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 May 2008 07:01:30 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JxjS3-0007kh-6h
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 May 2008 07:01:28 -0700
Date: Sun, 18 May 2008 10:01:21 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080518140121.GA5635@c2.user-mode-linux.org>
References: <804dabb00805180206wc937036x8e50336967f78ee3@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <804dabb00805180206wc937036x8e50336967f78ee3@mail.gmail.com>
Subject: Re: [uml-devel] ?struct thread_struct? has no member named ?mode?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Peter Teoh <htmldeveloper@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, May 18, 2008 at 05:06:55PM +0800, Peter Teoh wrote:
> I downloaded 2.6.24.2.tar.bz2 and make:

>   CC      arch/um/kernel/smp.o
> /mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c: In function 'idle_proc':
> /mnt/hd0/download/linux-2.6.24.2/arch/um/kernel/smp.c:79: error:
> 'struct thread_struct' has no member named 'mode'

This is what I get:

$ wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.24.2.tar.bz2
--09:48:55--  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.24.2.tar.bz2
           => `linux-2.6.24.2.tar.bz2'
Resolving www.kernel.org... 204.152.191.5, 204.152.191.37
Connecting to www.kernel.org|204.152.191.5|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 46,735,221 (45M) [application/x-bzip2]

100%[====================================>] 46,735,221   556.46K/s    ETA 00:00

09:50:11 (602.99 KB/s) - `linux-2.6.24.2.tar.bz2' saved [46735221/46735221]

$ bunzip2 linux-2.6.24.2.tar.bz2
$ tar xf linux-2.6.24.2.tar 
$ cd linux-2.6.24.2
$ mkdir uml
$ make defconfig ARCH=um O=uml
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/docproc
  	  ...
$ make ARCH=um O=uml
          ...
	  success

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
