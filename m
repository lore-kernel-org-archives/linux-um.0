Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040410170707.GA6492@ccure.user-mode-linux.org>
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net>
	<185d01c41e23$5996cc00$2000000a@schlepptopp>
	<189201c41e30$d434cc70$2000000a@schlepptopp>
	<200404091626.i39GQqsf002414@ccure.user-mode-linux.org>
	<c58kbu$el1$1@sea.gmane.org>
	<20040410140840.GB5782@ccure.user-mode-linux.org>
	<4077FDF9.7070707@upb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <4077FDF9.7070707@upb.de>
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
Date: Sat, 10 Apr 2004 13:07:07 -0400
Content-Transfer-Encoding: quoted-printable
To: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

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

The amounts of mlocked memory you're talking about are so large that they=20
could endanger the system.

> well, what do you mean with managing the host memory? will be some kind=20
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
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
