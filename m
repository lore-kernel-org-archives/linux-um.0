Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FvODx-0008Es-Qc for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 17:48:09 -0700
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FvODw-0006iT-Df
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 17:48:09 -0700
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5S0lvuV004776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 27 Jun 2006 20:47:58 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5S0lPhp095188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 27 Jun 2006 18:47:26 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5S0lviG030963 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 27 Jun 2006 18:47:57 -0600
Date: Tue, 27 Jun 2006 17:47:56 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
Message-ID: <20060628004756.GC4488@us.ibm.com>
References: <20060626220234.GG4223@us.ibm.com>
	<200606271656.13712.blaisorblade@yahoo.it>
	<20060627183128.GA4488@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060627183128.GA4488@us.ibm.com>
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

On 27.06.2006 [11:31:28 -0700], Nishanth Aravamudan wrote:
> On 27.06.2006 [16:56:13 +0200], Blaisorblade wrote:
> > On Tuesday 27 June 2006 00:02, Nishanth Aravamudan wrote:
> > > Hi Jeff,
> > >
> > > I run an x86_64 kernel with i386 userspace (Ubuntu Dapper) and decided
> > > to try out UML today. I found that UML wasn't quite aware of biarch
> > > compilers (which Ubuntu i386 ships). A fix similar to what was done for
> > > x86_64 should probably be committed (see
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=113425940204010&w=2).
> > 
> > Ok, it seemed strange but I understand the stuff... that's very
> > interesting as this is the setup I'd wished to have since ages. I'll
> > switch to it ASAP...
> 
> Indeed :)
> 
> > > Without the FLAGS changes, the build will fail at a number of places and
> > > without the LINK change, the final link will fail.
> > >
> > > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > 
> > The first hunk (#undef i386) should be unnecessary given you specify
> > -m64 (add it to CPPFLAGS too). Also it can/could be problematic for

Hrm, I somehow overlooked the CPPFLAGS bit. Is it necessary? That wasn't
changed for x86_64 and having not changed it for UML, it doesn't appear
to have prevented the build from working on both x86_64 and i386
SUBARCHs here.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
