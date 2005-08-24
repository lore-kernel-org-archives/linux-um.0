Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E7w3t-00074x-5z	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Aug 2005 07:17:05 -0700
Received: from wproxy.gmail.com ([64.233.184.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E7w3s-0006zu-Jn
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Aug 2005 07:17:05 -0700
Received: by wproxy.gmail.com with SMTP id i13so106878wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 24 Aug 2005 07:16:57 -0700 (PDT)
Message-ID: <838f7c50050824071665f2b081@mail.gmail.com>
From: ashwin tanugula <ashwin.tanugula@gmail.com>
Subject: Re: [uml-devel] uml for 2.6.12 kernel
In-Reply-To: <20050824034403.GA8036@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
References: <838f7c500508231455607e9a7d@mail.gmail.com>
	 <20050824034403.GA8036@mindspring.com>
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
Date: Wed, 24 Aug 2005 10:16:55 -0400
Content-Transfer-Encoding: 8bit
To: jleu@mindspring.com
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On 8/23/05, James R. Leu <jleu@mindspring.com> wrote:
> Since you didn't specify, I assume your talking about building
> a guest kernel.  In which case I just went through the the same ordeal.
> 
> I used a 2.6.12-mm2 kernel and applied jdike's patch set.  Here are the
> URLs for the parts you need.
> 
> http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/2.6.12-mm2.bz2
> http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.12-mm2/patches.tar
> 
> I'd be interested to see what others have gotten working.
> 
> On Tue, Aug 23, 2005 at 05:55:27PM -0400, ashwin tanugula wrote:
> > Hi,
> > I want to build UML from source using a 2.6.12 kernel. Can somebody
> > tell me whether to patch it or not as kernels from 2.6.9 have the UML
> > included??
> >
> > Thanks,
> > Ashwin
> >
> >
> > -------------------------------------------------------
> > SF.Net email is Sponsored by the Better Software Conference & EXPO
> > September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> > Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> > Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> > _______________________________________________
> > User-mode-linux-devel mailing list
> > User-mode-linux-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 
> --
> James R. Leu
> jleu@mindspring.com
> 
> 
> 
Hi,
I am more confused now...I want to build a basic UML for a 2.6.12
kernel, just like the other kernels..for a 2.6.0 kernel one need to
apply a uml-patch-2.6.12.tar.bz2 patch and build it.
so do I need to apply the 2.6.12-mm2.bz2 and patches.tar patches and build??

And can you tell me what a guest kernel is?

Thanks,
Ashwin


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
