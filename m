Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FvX3j-0007i0-CU for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jun 2006 03:14:11 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FvX3f-0004Uo-HK
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jun 2006 03:14:11 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 28 Jun 2006 12:13:21 +0200
References: <20060626220234.GG4223@us.ibm.com>
	<20060627183128.GA4488@us.ibm.com>
	<20060628004756.GC4488@us.ibm.com>
In-Reply-To: <20060628004756.GC4488@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606281213.21696.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Fix UML build on i386 Ubuntu Dapper
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 28 June 2006 02:47, Nishanth Aravamudan wrote:
> On 27.06.2006 [11:31:28 -0700], Nishanth Aravamudan wrote:
> > On 27.06.2006 [16:56:13 +0200], Blaisorblade wrote:
> > > On Tuesday 27 June 2006 00:02, Nishanth Aravamudan wrote:
> > > > Hi Jeff,
> > > >
> > > > I run an x86_64 kernel with i386 userspace (Ubuntu Dapper) and
> > > > decided to try out UML today. I found that UML wasn't quite aware of
> > > > biarch compilers (which Ubuntu i386 ships). A fix similar to what was
> > > > done for x86_64 should probably be committed (see
> > > > http://marc.theaimsgroup.com/?l=linux-kernel&m=113425940204010&w=2).
> > >
> > > Ok, it seemed strange but I understand the stuff... that's very
> > > interesting as this is the setup I'd wished to have since ages. I'll
> > > switch to it ASAP...
> >
> > Indeed :)
> >
> > > > Without the FLAGS changes, the build will fail at a number of places
> > > > and without the LINK change, the final link will fail.
> > > >
> > > > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > >
> > > The first hunk (#undef i386) should be unnecessary given you specify
> > > -m64 (add it to CPPFLAGS too). Also it can/could be problematic for
>
> Hrm, I somehow overlooked the CPPFLAGS bit. Is it necessary? That wasn't
> changed for x86_64 and having not changed it for UML, it doesn't appear
> to have prevented the build from working on both x86_64 and i386
> SUBARCHs here.

It shouldn't go in the general CPPFLAGS indeed.
I think that -m64 in the preprocessor command used to build vmlinux.lds.S 
would be cleaner than #undef i386... test it by preprocessing by hand and 
report, I'll code the CPPFLAGS_vmlinux.lds.S = -m64 assignment (if it is 
exactly this way) if it works.

Anyway, this is minor refinement, the patch is otherwise ok.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
