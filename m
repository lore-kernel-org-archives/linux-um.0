Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVodb-00060p-NF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Sep 2007 06:21:43 -0700
Received: from rtr.ca ([76.10.145.34] helo=mail.rtr.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IVodW-0004bW-Ra
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Sep 2007 06:21:43 -0700
Message-ID: <46E9395F.2090300@rtr.ca>
Date: Thu, 13 Sep 2007 09:21:35 -0400
From: Mark Lord <lkml@rtr.ca>
MIME-Version: 1.0
References: <46E81AC6.3000306@googlemail.com> <46E8A572.7050209@rtr.ca>
	<20070913093651.GA5077@suse.de>
In-Reply-To: <20070913093651.GA5077@suse.de>
Subject: Re: [uml-devel] [1/4] 2.6.23-rc6: known regressions
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
To: Greg KH <gregkh@suse.de>
Cc: Jakub Jelinek <jakub@redhat.com>, Len Brown <len.brown@intel.com>, Oliver Neukum <oneukum@suse.de>, Adrian Bunk <bunk@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Stefan Becker <Stefan.Becker@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Markus <lists4me@web.de>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, linux-alpha@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jeff Dike <jdike@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "Antonino A. Daplas" <adaplas@gmail.com>

Greg KH wrote:
> On Wed, Sep 12, 2007 at 10:50:26PM -0400, Mark Lord wrote:
>> Michal Piotrowski wrote:
>>> Hi all,
>>> Here is a list of some known regressions in 2.6.23-rc6.
>> ...
>>
>> Missing from the list:
>>
>> USB "autosuspend" feature (new in 2.6.23) breaks *lots* of devices.
>> Many have since been blacklisted in one-at-a-time discovery patches,
>> but that's really just the tip of the iceberg.
>>
>> This "feature" breaks a TON of user-visible things,
>> mostly USB storage devices (USB drives/pens, digicams, etc..).
>>
>> The functionality is broken for just too much stuff,
>> and needs to either be reverted or defaulted to "off" rather than "on".
> 
> Ok, after conferring with Oliver this morning, I think the best solution
> here is to both revert the usb-storage suspend patch as it has some
> basic problems that can cause data loss, _and_ add the change to the
> kernel that by default disables autosuspend on all USB devices except
> hubs.

Sounds like a sane approach.

Hopefully the kinks can be worked out in time for a reattempt in 2.6.24.
I understand how important this stuff is for battery powered devices,
but it just doesn't appear to be ready yet.

Cheers

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
