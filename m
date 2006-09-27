Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GSf9I-0001Ap-65 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 12:32:52 -0700
Received: from vms042pub.verizon.net ([206.46.252.42])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GSf9G-00031k-T4
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 12:32:52 -0700
Received: from smtp.davehollis.com ([72.64.146.245])
	by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02
	(built Sep
	9 2005)) with ESMTPA id <0J690007PNMCY8V0@vms042.mailsrvcs.net> for
	user-mode-linux-devel@lists.sourceforge.net; Wed,
	27 Sep 2006 14:32:37 -0500 (CDT)
Date: Wed, 27 Sep 2006 15:32:26 -0400
From: dhollis@davehollis.com
In-reply-to: <200609271757.k8RHvmgj005727@ccure.user-mode-linux.org>
Message-id: <20060927153226.pem81wc3k0ko48k4@web.davehollis.com>
MIME-version: 1.0
Content-disposition: inline
References: <200609271757.k8RHvmgj005727@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH 1/5] UML - Assign random MACs to interfaces
	if	necessary
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Quoting Jeff Dike <jdike@addtoit.com>:

> Assign a random MAC to an ethernet interface if one was not provided on
> the command line.  This became pressing when distros started
> bringing interfaces up before assigning IPs to them.  The previous
> pattern of assigning an IP then bringing it up allowed the MAC to be
> generated from the first IP assigned.  However, once the thing is
> up, it's probably a bad idea to change the MAC, so the MAC stayed
> initialized to fe:fd:0:0:0:0.
>
> Now, if there is no MAC from the command line, one is generated.  We
> use the microseconds from gettimeofday (20 bits), plus the low 12
> bits of the pid to seed the random number generator.  random() is
> called twice, with 16 bits of each result used.  I didn't want to
> have to try to fill in 32 bits optimally given an arbitrary
> RAND_MAX, so I just assume that it is greater than 65536 and use 16
> bits of each random() return.
>
> There is also a bit of reformatting and whitespace cleanup here.
>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>

Couldn't you use random_ether_addr() from linux/etherdevice.h?

static inline void random_ether_addr(u8 *addr)
{
         get_random_bytes (addr, ETH_ALEN);
         addr [0] &= 0xfe;       /* clear multicast bit */
         addr [0] |= 0x02;       /* set local assignment bit (IEEE802) */
}


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
