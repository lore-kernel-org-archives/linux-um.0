Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYNY0-00GNgZ-HA
 for linux-um@lists.infradead.org; Thu, 07 Oct 2021 07:10:34 +0000
Subject: Re: Bug 214611 - UM: stdout output ceases under certain conditions
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
 <f27a4ea1bafcb59ee5946bcdba6af6357007a515.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <c3f73fde-ac40-bc92-e659-8ea809d063c4@kot-begemot.co.uk>
Date: Thu, 7 Oct 2021 08:10:28 +0100
MIME-Version: 1.0
In-Reply-To: <f27a4ea1bafcb59ee5946bcdba6af6357007a515.camel@sipsolutions.net>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, development@efficientek.com
Cc: linux-um@lists.infradead.org

On 07/10/2021 08:03, Johannes Berg wrote:
> On Thu, 2021-10-07 at 08:00 +0100, Anton Ivanov wrote:
>> The detection that a file "behind" a device is closed at present
>> presently happens in the interrupt controller - it maps EPOLL events on
>> the fds to IRQs. All file IO gets multiplexed through there.
> True. But it really just causes an IRQ event to be reported, the upper
> layer is still responsible for reading and then handling the error on
> the FD.
>
>> All in all, if we add this functionality to the console/tty channels it
>> should be an extra option, because it is opposite to existing behavior.
> As I pointed out earlier in the thread, somehow providing a way to get
> chan->primary be not set would already provide the necessary behaviour.
> I believe even when the FDs are identical (e.g. a socket), because we
> separate read/write epoll and error handling.

The easiest way to provide this behavior is to add an option to the tty 
command line args and parse it. An optional extra "[,options]" after the 
fds will do the job.

>
> johannes
>
>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

