Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BEE37-0007TR-3J for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Apr 2004 14:05:29 -0700
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BEE36-0005Zz-8M for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Apr 2004 14:05:28 -0700
Message-ID: <009701c4232e$453e8710$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net>
	<185d01c41e23$5996cc00$2000000a@schlepptopp>
	<189201c41e30$d434cc70$2000000a@schlepptopp>
	<200404091626.i39GQqsf002414@ccure.user-mode-linux.org>
	<c58kbu$el1$1@sea.gmane.org>
	<20040410140840.GB5782@ccure.user-mode-linux.org>
	<4077FDF9.7070707@upb.de>
	<20040410170707.GA6492@ccure.user-mode-linux.org>
	<224701c42280$f110e0f0$2000000a@schlepptopp>
	<000801c422e1$783f8030$1400a8c0@DAVIDVAIO>
	<407EADE0.8010308@cox.net>
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
Date: Thu, 15 Apr 2004 23:11:47 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Dan Lund <arkane@cox.net>, David Cannings <lists@edeca.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>

damn - a really controversial theme!

:)

this have been two really completely different opinions.
personally, i don`t really NEED that mlock patch very urgently - so i`m not 
really pissed of, if it doesn`t go into uml.
but i would be sad if it`s being drpped completely.

lets give an example:
if i drive a car, i can even kill people or kill myself - by accident.
does somebody stop driving cars or do manufacturers stop building cars 
or limiting speed of cars because of that fact?
no.
cars give people an option to move quickly from one location to another. 
and it`s up to themselves to deceide, if that`s worth putting othere peoples
life or their own life at risk.

maybe this isn`t the best "comparison" - but i really miss the point, why a 
feature, which is useful for some people shouldn`t be included into a software, 
when it helps fixing a problem for them.
just excluding that feature, because of some "theory" that it COULD probably "hurt" 
others?
that`s the same as if developers of "dd" disable writing to files from that tool - because
somebody could accidentally fill up a whole harddrive (dd if=/dev/zero of=test.dat ...)
with that.

what about the fact, that this patch actually seems so solve a problem and adds flexibility 
to uml?

as i already said - there could be a big "WARNING" put to that option, so everybody
who uses it, is made aware of the bells and whistles and potential problems resulting 
from this.

something like this?:

+static int __init uml_mlock_setup(char *line, int *add)
+{
+ physmem_lock = 1;
+ return 0;
+}
+__uml_setup("mlock", uml_mlock_setup,
+"mlock\n"
+"    WARNING! Using this option could put your host at risk!\n"
+"    First read the documentation before using it!\n"
+"    \n"
+"    This option requests that the user-mode kernel's memory be locked\n"
+"    into the host kernel's RAM so that it cannot be swapped out.\n"
+"    This option requires that the user-mode kernel is run with root\n"
+"    privileges, which it drops after the mapping has been done.\n"
+);

to have both sides being satisfied, a good "compromise" could be, if that patch
is maintained separatately or (better) is being made a compile option, which is OFF by 
default.

regards
roland



----- Original Message ----- 
From: "Dan Lund" <arkane@cox.net>
To: "David Cannings" <lists@edeca.net>; "UML" <user-mode-linux-user@lists.sourceforge.net>
Sent: Thursday, April 15, 2004 5:44 PM
Subject: Re: [uml-user] Network lags


> David Cannings wrote:
> 
> >mlocking would have the effect of being able to "squeeze" less customers
> >onto a physical machine.  Without mlocking, pages can be swapped out of
> >memory onto disk thus your available memory is limited only by whatever size
> >swap partition you can afford.>snip<
> >  
> >
> I normally stay quiet, but this is an area that I have a vested interest 
> in with my UML usage.
> I have a machine with 8 gigs of ram, and I'm running 4 UML sessions 
> (along with a couple vmware sessions for Windows PDC/BDC/etc) and I see 
> my UMLs swap out quiete often.  I run 512Mb on each of them, and with my 
> 'free' statements I can see I have enough cache/buffer to spare to not 
> do this.  It does it though.  In a situation where you don't want your 
> UMLs to swap out, an option would be nice.  Just testing on another box 
> with 2 gigs ram, I turned off the swap and now it's running gorgeously.  
> I can't do that on my production system, though, because there are 
> processes that run in batch occasionally that do use memory into the 
> swap region.
> 
> >The problem with "just activating that option" is that many people will do
> >it blindly, unaware of the serious implications it could have to their host.
> >  
> >
> 
> It's best not to keep an option out because you think someone will use 
> it without realizing what it is.  If that's the case, the vanilla kernel 
> should take out the packet generator, or kernel debugging.  Both can 
> have serious implications on either the local machine, or on another 
> machine on the network.  Heck, just selecting certain things wrong in 
> the Linux kernel when configuring it can have serious implications.  
> That's what the help portion of menuconfig is really for, to alert the 
> user to how to properly handle that option.
> 
> >Whilst mlocking an area of memory may not affect you now, or in the next ten
> >minutes, it could cause trouble in three weeks when you start doing
> >something on the host that is memory intensive.  
> >
> If it's mlocked, your host will use swap for the other processes once it 
> uses the ram that's still available.  But, it's predictable.
> If you have 1 gig of ram, you mlock a 512mb UML, you always have 512mb 
> left for the kernel/processes.  If I'm not mistaken, VMWare does it that 
> way, or at least locks a certain amount of ram in some way.
> 
> >In the last three years of
> >running a remote server I have only had to turn up on site to fix it twice.
> >Both were very silly things, one that I'd "just activated" to see what it
> >would do.  It cost me a rather expensive journey half way across the country
> >to fix.
> >  
> >
> There is one thing I've learned very early on.  Don't experiment with 
> machines that you can't touch.
> I've been burned by that too many times, and it's a mantra I live by 
> now.  When I'm doing something new, I do it here.  If it works, I 
> implement it in Texas, 2 states east.  If I turned a "just activated" 
> something in Texas, can you imagine what would happen if it broke?
> 
> >It is definitely good to see a community working on patches for a project
> >but it must be recognised that the end result should be a professional,
> >stable and reliable product.  
> >
> And so it shall be, with or without mlock, or any other features that 
> are implemented for that matter.
> 
> >I am sure nobody has any problem with people
> >posting patches on their own sites or on the mailing list to allow people to
> >carry out certain tasks but modifications that contain potentially unstable
> >code should, in my opinion, be left out of a mainstream release.  Note that
> >I speak for myself here, not UML or Jeff Dike.
> >
> >  
> >
> That's why any new code needs to be tested, ran through the wringer so 
> to speak, bug fixed, repeat as necessary.  That goes for UML in general.
> 
> >The idea behind UML is to create a separate environment from the host,
> >constructing a UML kernel that can interfere so badly with the host is the
> >total opposite.
> >
> >  
> >
> I fail to see how allocating all of your memory in the beginning is a 
> bad thing.  It's just a different philosophy of VM.  It won't put your 
> host at risk, unless your host runs the UML, along with something else 
> that will take ($TOTAL_RAM - $UMLRAM) + $SWAPSIZE.
> It's better than the alternative: Running a host without a swap 
> partition to keep it from swapping out.
> 
> >That statement is asinine.  I could just change "some lines" in my shell
> >scripts to read "rm -rf /" instead.  Is that not a big issue?  I do not
> >understand kernel design very well at all but changing "some lines" of
> >source can have serious implications.
> >
> >  
> >
> 
> Let's not get silly.  Of course, as a competent script writer you are 
> going to realize that rm -rf / is a bad thing.  The same with a coder 
> realizing something being bad.
> If people had this type of mindset back when initrd/ramdisk/software 
> raid were being put into the Linux kernel, it would have never made it 
> into the official kernel.
> Options are good, even if they go against your convictions.
> 
> --Dan
> 
> -----------
> This email message and any attachment may contain Confidential or
> Protected Health Information. If you are not the intended recipient
> please notify us immediately at 480-648-4545 and delete the message.
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
