Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDugM-00061b-VS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 17:24:42 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BDugM-0007Sl-6j for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Apr 2004 17:24:42 -0700
Message-ID: <224701c42280$f110e0f0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net>
	<185d01c41e23$5996cc00$2000000a@schlepptopp>
	<189201c41e30$d434cc70$2000000a@schlepptopp>
	<200404091626.i39GQqsf002414@ccure.user-mode-linux.org>
	<c58kbu$el1$1@sea.gmane.org>
	<20040410140840.GB5782@ccure.user-mode-linux.org>
	<4077FDF9.7070707@upb.de>
	<20040410170707.GA6492@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Thu, 15 Apr 2004 02:31:04 +0200
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>, =?iso-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

hi !
> what's so bad about it?
same statement from me.

whats so bad about mlocking?

i would like to bring Matthew Blochs patch back into discussion, since it g=
ives an OPTION to mlock a uml.

see thread at:
http://marc.theaimsgroup.com/?l=3Duser-mode-linux-devel&w=3D2&r=3D1&s=3DLoc=
king+user-mode+kernel+RAM+into+host+p&q=3Db

btw: i like options ;)

from the mail of matthew:

>The 2.4 kernel does appear to swap out
>applications when (e.g.) a large file copy is underway
.
..
>I like the sound of the more dynamic memory arrangement and manager daemon=
 for
>UMLs, sounds like a good way to squeeze more customers onto a host machine.
>But if for the moment the only thing it should do is to keep the host from
>swapping, I know from a few our customers that mlocking has given more
>predictable behaviour from guest kernels, especially if the host load spik=
es
>for a few minutes.

this is a statement from a person whe has some advanced practical experienc=
e with uml!

>Anyone else who's running lots of UMLs with interactive sessions may have
>noticed the following symptoms which this patch cures:
>
>   * irregular ping times to UMLs-- huge delay for the first ping, a few
>       normal, a couple of long delays etc.;
>   * long gaps in interactive response (having to "wake it up" with some
>       keypresses), especially after connecting for the first time in a few
>       hours.

as far as i remember this problems have been reported repeatedly - so all u=
sers who experience
weird uml lags could probably fix their problem just by activating that opt=
ion. furthermore inclusion
of the patch would "honour" the work of the person, who did that patch. per=
sonally, i find such thing
important for an opensource project, because it is some form of "encouragem=
ent" to develop patches and
giving credits to others. :)

yes it is somewhat "controversial" if mlocking is good or bad. but since an=
 option is an option, the
"professional user" can decide himself.

>It can put the host at risk.
i think someone who runs a uml KNOWS what he does - and is able to calculat=
e the amount of ram on his host
and reserve free ram for i/o buffering or whatelse....

>mlocking large amounts of memory subverts that and increases the possibili=
ty of deadlocking.
right! but this option could be documented with a "warning": use with care!=
 this could endanger your system!

furthermore - that patch doesn`t seem to be such "big issue" because it`s j=
ust some lines of code being changed
in uml.....

i would like to give a (late) vote for inclusion of that patch.

regards
roland



----- Original Message -----=20
From: "Jeff Dike" <jdike@addtoit.com>
To: "Sven K=F6hler" <skoehler@upb.de>
Cc: <user-mode-linux-user@lists.sourceforge.net>; <user-mode-linux-devel@li=
sts.sourceforge.net>
Sent: Saturday, April 10, 2004 7:07 PM
Subject: Re: [uml-user] Network lags


On Sat, Apr 10, 2004 at 04:00:25PM +0200, Sven K=F6hler wrote:
> what's so bad about it?

It can put the host at risk.  There's a VM system for a reason, and it needs
swap in order to be able to back out of memory shortages.  mlocking large
amounts of memory subverts that and increases the possibility of deadlockin=
g.

There are only a few good reasons for mlocking, and performance isn't one of
them:
when something would break horribly if a page got swapped, i.e. pending
DMA or directIO into it
security - gpg wants to mlock a page so it can be sure that secrets
on it won't be written to disk

Those only involve a page at a time, and don't possibly endanger the system.

The amounts of mlocked memory you're talking about are so large that they
could endanger the system.

> well, what do you mean with managing the host memory? will be some kind
> tool or built-in option of the UML-kernel?

Both.  There is pluggable memory in UML, and a tool on the host to manage
memory by moving memory between UMLs and between UMLs and the host.

So, this daemon would be watching memory use on the host and the UMLs, and
if it saw the host running short, it would find an idle UML and take some
memory away from it:
uml_mconsole <idle_umid> config mem=3D-32M

This would free the memory to the host, and pull it away from swap.

If the host was fine, but another UML was short of memory, it would then
give that memory to the busy UML:
uml_mconsole <busy_umid> config mem+=3D32M

Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dick
_______________________________________________
User-mode-linux-user mailing list
User-mode-linux-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
