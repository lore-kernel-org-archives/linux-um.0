Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <000801c422e1$783f8030$1400a8c0@DAVIDVAIO>
From: "David Cannings" <lists@edeca.net>
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net>
	<185d01c41e23$5996cc00$2000000a@schlepptopp>
	<189201c41e30$d434cc70$2000000a@schlepptopp>
	<200404091626.i39GQqsf002414@ccure.user-mode-linux.org>
	<c58kbu$el1$1@sea.gmane.org>
	<20040410140840.GB5782@ccure.user-mode-linux.org>
	<4077FDF9.7070707@upb.de>
	<20040410170707.GA6492@ccure.user-mode-linux.org>
	<224701c42280$f110e0f0$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] Network lags
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
Date: Thu, 15 Apr 2004 13:01:49 +0100
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

> >I like the sound of the more dynamic memory arrangement and manager
daemon for
> >UMLs, sounds like a good way to squeeze more customers onto a host
machine.
> >But if for the moment the only thing it should do is to keep the host
from
> >swapping, I know from a few our customers that mlocking has given more
> >predictable behaviour from guest kernels, especially if the host load
spikes
> >for a few minutes.

mlocking would have the effect of being able to "squeeze" less customers
onto a physical machine.  Without mlocking, pages can be swapped out of
memory onto disk thus your available memory is limited only by whatever size
swap partition you can afford.  This way, even if you only have 256MB
physical memory you can run ten UMLs with 64MB each, as an untested example
figure.  If you mlock those 64MB for each UML you can only physically run
four, not including space for host kernel and user space memory.  Obviously
there are huge performance penalties by constantly swapping out pages so
more physical memory or faster swap do help.

> >Anyone else who's running lots of UMLs with interactive sessions may have
> >noticed the following symptoms which this patch cures:
> >
> >   * irregular ping times to UMLs-- huge delay for the first ping, a few
> >       normal, a couple of long delays etc.;

The huge delay is often related to ARP, a fundamental part of 802.3/true
ethernet.

> as far as i remember this problems have been reported repeatedly - so all
users who experience
> weird uml lags could probably fix their problem just by activating that
option.

The problem with "just activating that option" is that many people will do
it blindly, unaware of the serious implications it could have to their host.
Whilst mlocking an area of memory may not affect you now, or in the next ten
minutes, it could cause trouble in three weeks when you start doing
something on the host that is memory intensive.  In the last three years of
running a remote server I have only had to turn up on site to fix it twice.
Both were very silly things, one that I'd "just activated" to see what it
would do.  It cost me a rather expensive journey half way across the country
to fix.

> furthermore inclusion
> of the patch would "honour" the work of the person, who did that patch.
personally, i find such thing
> important for an opensource project, because it is some form of
"encouragement" to develop patches and
> giving credits to others. :)

It is definitely good to see a community working on patches for a project
but it must be recognised that the end result should be a professional,
stable and reliable product.  I am sure nobody has any problem with people
posting patches on their own sites or on the mailing list to allow people to
carry out certain tasks but modifications that contain potentially unstable
code should, in my opinion, be left out of a mainstream release.  Note that
I speak for myself here, not UML or Jeff Dike.

> >It can put the host at risk.
> i think someone who runs a uml KNOWS what he does - and is able to
calculate the amount of ram on his host
> and reserve free ram for i/o buffering or whatelse....

The idea behind UML is to create a separate environment from the host,
constructing a UML kernel that can interfere so badly with the host is the
total opposite.

> furthermore - that patch doesn`t seem to be such "big issue" because it`s
just some lines of code being changed
> in uml.....

That statement is asinine.  I could just change "some lines" in my shell
scripts to read "rm -rf /" instead.  Is that not a big issue?  I do not
understand kernel design very well at all but changing "some lines" of
source can have serious implications.

I agree with Jeff, mlocking is bad.

David



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
