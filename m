Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYNR7-00GLtf-8S
 for linux-um@lists.infradead.org; Thu, 07 Oct 2021 07:03:27 +0000
Message-ID: <f27a4ea1bafcb59ee5946bcdba6af6357007a515.camel@sipsolutions.net>
Subject: Re: Bug 214611 - UM: stdout output ceases under certain conditions
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 07 Oct 2021 09:03:17 +0200
In-Reply-To: <0e867e3c-80e5-de8a-8da2-2d1baedde2d5@kot-begemot.co.uk>
References: <20211002210023.55861502@crass-HP-ZBook-15-G2>
 <aad9145655670d2f7d06a8dffd93d99171183fe0.camel@sipsolutions.net>
 <20211004115410.4716345d@crass-HP-ZBook-15-G2>
 <3fa82a81-83b5-0e14-9a9d-36282a77d177@kot-begemot.co.uk>
 <9fe55088-219a-67a4-a34c-91b92dc5c3c8@kot-begemot.co.uk>
 <20211006130531.26a17e49@crass-HP-ZBook-15-G2>
 <c5fc1068-a33b-dfa3-d8f1-36081e2ebfce@kot-begemot.co.uk>
 <20211006144817.0fbf821e@crass-HP-ZBook-15-G2>
 <5606fffc-a750-4e13-e805-ccd640f7de6d@kot-begemot.co.uk>
 <20211006162827.71919c7f@crass-HP-ZBook-15-G2>
 <0e867e3c-80e5-de8a-8da2-2d1baedde2d5@kot-begemot.co.uk>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, development@efficientek.com
Cc: linux-um@lists.infradead.org

On Thu, 2021-10-07 at 08:00 +0100, Anton Ivanov wrote:
> 
> The detection that a file "behind" a device is closed at present 
> presently happens in the interrupt controller - it maps EPOLL events on 
> the fds to IRQs. All file IO gets multiplexed through there.

True. But it really just causes an IRQ event to be reported, the upper
layer is still responsible for reading and then handling the error on
the FD.

> All in all, if we add this functionality to the console/tty channels it 
> should be an extra option, because it is opposite to existing behavior.

As I pointed out earlier in the thread, somehow providing a way to get
chan->primary be not set would already provide the necessary behaviour.
I believe even when the FDs are identical (e.g. a socket), because we
separate read/write epoll and error handling.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

