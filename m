Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rob@landley.net>) id 1SrBR6-0001hH-EQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jul 2012 17:19:48 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SrBR5-0003XG-DM
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jul 2012 17:19:48 +0000
Received: by obcva7 with SMTP id va7so874053obc.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 Jul 2012 10:19:41 -0700 (PDT)
Message-ID: <50059EAA.9080000@landley.net>
Date: Tue, 17 Jul 2012 12:19:38 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
References: <4FFDA698.2000707@landley.net> <20120713030325.GB12245@thunk.org>
	<50032B11.7070505@landley.net> <20120716152140.GA27656@thunk.org>
In-Reply-To: <20120716152140.GA27656@thunk.org>
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
Subject: Re: [uml-devel] feature-removal-schedule entry from 2009
To: Theodore Ts'o <tytso@mit.edu>, user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com

That should be over on _this_ list then...

(Discussion of IRQF_SAMPLE_RANDOM removal.)

On 07/16/2012 10:21 AM, Theodore Ts'o wrote:
> On Sun, Jul 15, 2012 at 03:41:53PM -0500, Rob Landley wrote:
>> Does it become a "please add a call to sample_interrupt_randomness()"
>> reminder, or will the infrastructure figure out when to do that outside
>> the driver?
> 
> The patches in the random.git tree unconditionally call
> add_interrupt_randomness() in handle_irq_event_percpu(), so the
> drivers don't need to do anything at this point.
> 
>> And will this upcoming patch set remove 'em, or leave the NOP debris
>> there?
> 
> The current status is here:
> 
> http://git.kernel.org/?p=linux/kernel/git/tytso/random.git;a=summary
> 
> At this point the flag is a no-op, and can be removed.  This close to
> the merge window, I don't think I'm going to have time to create
> patches which remove the flag from all of the drivers, but it's
> basically clean up work, and having the extra bit set isn't going to
> harm anyone.
> 
> The only thing that might require a bit of care is the usage in
> arch/um, where someone needs to do a bit more analysis to see if it's
> just a matter of removing the flag from the call to request_irq().  My
> current thinking was to merge the new interrupt structure during this
> merge window, and then clean up the NOP debris during the next
> development cycle.
> 
> 						- Ted
> 
> 

Rob
-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

