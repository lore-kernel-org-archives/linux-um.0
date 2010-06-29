Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1OTftg-00085K-GP
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2010 18:51:04 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OTftf-0007Sm-3c
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2010 18:51:04 +0000
Date: Tue, 29 Jun 2010 11:50:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20100629115029.4eccea6e.akpm@linux-foundation.org>
In-Reply-To: <4C29B034.8070208@panasas.com>
References: <AANLkTikziSEDW07YiiJs6ny6JLhSQ-TGvdw_kTroIIx5@mail.gmail.com>
	<4C1809D3.7030707@panasas.com>
	<AANLkTikYn_EwizmUq6ZxitJ6ibCkr8Nfd4yslK_Bo0zR@mail.gmail.com>
	<4C29B034.8070208@panasas.com>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] um: Include missing header file in
 os-linux/mem.c
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
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Jeff Dike <jdike@addtoit.com>, Liu Aleaxander <aleaxander@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org

On Tue, 29 Jun 2010 11:35:00 +0300
Boaz Harrosh <bharrosh@panasas.com> wrote:

> On 06/15/2010 11:06 AM, Liu Aleaxander wrote:
> > The os-linux/mem.c file calls fchmod function, which is declared in sys/stat.h
> > header file, so include it.
> > 
> > Signed-off-by: Liu Aleaxander <Aleaxander@gmail.com>
> > ---
> >  arch/um/os-Linux/mem.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
> > index 93a11d7..e696144 100644
> > --- a/arch/um/os-Linux/mem.c
> > +++ b/arch/um/os-Linux/mem.c
> > @@ -10,6 +10,7 @@
> >  #include <errno.h>
> >  #include <fcntl.h>
> >  #include <string.h>
> > +#include <sys/stat.h>
> >  #include <sys/mman.h>
> >  #include <sys/param.h>
> >  #include "init.h"
> > 
> 
> On 06/15/2010 04:06 AM, Liu Aleaxander wrote:
> > On Wed, Jun 16, 2010 at 7:16 AM, Boaz Harrosh <bharrosh@panasas.com> wrote:
> >>
> >> Yes. I have the same patch.
> >>
> >> Apparently it's new for Fedora 13. Previous Fedora's are compiling fine.
> > 
> > Same here:)
> > 
> >> I guess something has changed with the new gcc headers include sequence
> > 
> 
> Andrew? Jeff? someone?

I got it.

> I saw that some uml patches where pushed for -rc4. What about this patch?
> could some one push this patch? It's for FC13 compilation?
> 
> It might be needed for stable@ as well. I'll try to test with old Kernels.
> Am back on an FC12 in the office so it'll take some time.

Yes, it's needed in -stable.  People will want to compile 2.6.34 under
FC13.



------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

