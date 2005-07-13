Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <F47F4E3B83BE854AA0BCB998C69295169D2D9F@tiki.fastmail.usf.edu>
From: "Gaspar, Alessio (USF Lakeland)" <alessio@lklnd.usf.edu>
Subject: [uml-devel] RE: [uml-user] RE: 2.6.12-bb2-skas0 hanging after INIT
	(CORRECTION PREVIOUS POST)
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
Date: Wed, 13 Jul 2005 11:48:24 -0400
Content-Transfer-Encoding: 8bit
To: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-user@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net

> > Summary of results
> >
> > SKAS + TT			./linux-tt-skas
> > hangs
> > 				./linux-tt-skas mode=tt		hangs
> > TT only			./linux-tt
hangs
> >
> >
> > In all cases, boot hangs on sleeping process gets unexpected signal
10
> Ok, now let's wait a moment. Can you run, on the same machine, a
vanilla
> kernel (even 2.6.10) and verify on that if TT mode works?

Am on it, will be done by tonight

> Nobody has ever seen this kind of crash, so I want to see if it's
> userspace
> related (some strange GCC/glibc/headers problem) or if it's the kernel
> triggering it (either a bug in SSI, or a bug of UML which is only
> triggered
> in that environment). I say "some machine" because distro differences
> could
> be part of the picture.
> 
> Btw, is the host being part of a cluster at the testing moment or not?

The host is a masternode for the cluster, all other nodes are OFF for
now but the openSSI is active

> Also, on the community page there's a link about these setups (CILinux
> seems
> related with OpenSSI, if not the same thing):
> 
> http://usermodelinux.org/modules.php?name=News&file=article&sid=185

Yup, but the link above is for combining uml + openssi so that you can
set up a "virtual" ssi cluster (several UMLs, one acting as masternode,
the others as members of the cluster)

In my case, this is the other way around; the host is a open SSI
masternode to which ppl will connect to play around with their own
UML(s). So the UML boxes won't even know they are working on a SSI
cluster and not a single host. 


> 
> Btw, is OpenSSI purpose anyhow different from OpenMosix one or not?
Just
> as a
> curiosity about OpenSSI (I'd like to understand a bit more what it
does,
> I'm
> seeing the "features" page).


Their global objective is the same; providing a single system image so
that you can work on a node and have processes migrating all over the
cluster depending on the load of each nodes. OpenSSI uses the same
algorithms than open Mosix for load balancing but the implementation is
different (less residual information about processes on their initial
starting node as far as I understand). Now OpenSSI goes a step farther
in my opinion, providing options for cluster file systems and (that's
why I use it) incoming tcp/ip connections load balancing (using the LVS
project merged with open mosix algorithms). 

The result is a cluster balancing both processes and connections (thus
the node on which processes start). This can be relevant in case of
several users trying to compile a kernel (short gcc processes spawned
are not lasting long enough to be migrated on the cluster so, if several
users compile their own kernels, they can end up clogging 1 single node
if they have not be redirected to balance connections)

Let me know if I don't make sense, I'll try to be clearer when I post
the results of the vanilla 2.6.10 host kernel test. 

Alessio


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
