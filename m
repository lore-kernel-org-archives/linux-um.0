Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlgNU-0003h0-CI for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 19:28:32 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1AlgNT-0003Qq-Pa
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 19:28:31 -0800
From: Dan Shearer <dan@shearer.org>
Subject: Re: [uml-devel] Re: [PATCH] mconsole fixes
Message-ID: <20040128033044.GQ4203@erizo.shearer.org>
References: <20040126024617.GB4203@erizo.shearer.org>
	<200401280146.i0S1kaZw004957@ccure.user-mode-linux.org>
	<20040128021652.GP4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20040128021652.GP4203@erizo.shearer.org>
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
Date: Wed, 28 Jan 2004 14:00:44 +1030
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Jan 28, 2004 at 12:46:52PM +1030, Dan Shearer wrote:
> On Tue, Jan 27, 2004 at 08:46:36PM -0500, Jeff Dike wrote:
 
> > I applied most of the rest of that.  I got rid of the exits from main, since
> > I like returns better and I tidied up some other stuff.
> 
> Minor portability potential. See
> http://www.eskimo.com/~scs/C-faq/q11.16.html. (I looked it up once long
> ago and supposedly _exit is more likely to work on more systems than
> exit.)

Actually on second thoughts that is not relevant (applies to functions
other than main.)

However there is only one way that the standard guarantees we can
indicate a status to the OS and that is exit(EXIT_FAILURE) or
EXIT_SUCCESS. return(whatever) works on the sane OSs that we're used to,
but the standard is there for a reason. So that should be used instead.

-- 
Dan Shearer
dan@shearer.org


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
