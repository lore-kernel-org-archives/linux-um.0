Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ar5vL-0005Jd-H6
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 17:45:51 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30)
	id 1Ar5uU-0000yc-AH
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 17:44:58 -0800
From: Dan Shearer <dan@shearer.org>
Subject: Re: [uml-devel] mconsole telinit design, worry about init standards?
Message-ID: <20040212014725.GV4203@erizo.shearer.org>
References: <20040206003759.GY4203@erizo.shearer.org> <200402120114.i1C1E5ip008500@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200402120114.i1C1E5ip008500@ccure.user-mode-linux.org>
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
Date: Thu, 12 Feb 2004 12:17:25 +1030
To: Jeff Dike <jdike@addtoit.com>
Cc: Cameron Patrick <cameron@patrick.wattle.id.au>, BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, miquels@cistron.nl

Jeff,

On Wed, Feb 11, 2004 at 08:14:05PM -0500, Jeff Dike wrote:
> dan@shearer.org said:
> > I've got a rough implementation of an mcsonole telinit command, where
> > mconsole_kern opens /dev/initctl and sends a command to change
> > runlevels.
> 
> cameron@patrick.wattle.id.au said:
> > How about having some kind of generic interface to allow the host to
> > access files, send signals, etc inside the VM?
> 
> Sorry, but none of these handy things are going into the kernel.  If you want
> to run processes, open files, etc, you can do all that from userspace.

Could you tell us what the rules are? At some level we can interact with
the kernel (eg call the c-a-d and halt handlers.) Yet at another we
can't (run processes.) This has to do with how much potential there is
for trouble. Would you be happy with sending signals? If so, even RT
signals, which have a payload? If not, perhaps you could indicate which
class of things you are happy for us to trigger. Perhaps only things
which can be conceptually related to the hardware... so long as we know.

This is part of having a clearer model about what UML is.

> I see the following possibilities:

Yes, the things you propose will work. The bit that we have been trying
to get away from here (in more or less ambitious ways:-) is cooperation
from the UML. I don't mind relying on the UML root being non-hostile (in
many cases that is their right to be relatively hostile if they like,
hosting is that sort of a thing :-) but I want to avoid requiring more
than a tiny minimum above ordinary software intstalled, or better still
nothing at all.

-- 
Dan Shearer
dan@shearer.org


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
