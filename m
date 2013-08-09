Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1V7u4x-0001uM-L0
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 21:18:35 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V7u4t-0005e0-W9
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 21:18:35 +0000
Message-ID: <52055CA0.2090301@nod.at>
Date: Fri, 09 Aug 2013 23:18:24 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <20130809204355.GA10864@redhat.com>
	<20130809211512.GB10864@redhat.com>
In-Reply-To: <20130809211512.GB10864@redhat.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Using UML in libguestfs
To: user-mode-linux-devel@lists.sourceforge.net

Am 09.08.2013 23:15, schrieb Richard W.M. Jones:
> On Fri, Aug 09, 2013 at 09:43:55PM +0100, Richard W.M. Jones wrote:
>> * I'm trying to use a serial port to communicate between guest and
>> host, using ssl3=fd:<N>.  This causes the Linux process to crash soon
>> (but not immediately) after the guest has opened /dev/ttyS3:
>>
>>   spurious interrupt in ubd_handler, err = -4
> 
> So I realized this is caused by a coding mistake by me.  I had set to
> O_CLOEXEC flag on the file descriptor, so it was being closed across
> the exec of vmlinux.
> 
> It still doesn't quite work, but the error above has gone away.

So you are still facing the crash are reported in your first mail?

Thanks,
//richard


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

