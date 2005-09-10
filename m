Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EE9vZ-0007C1-IM	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:18:13 -0700
Received: from sccrmhc12.comcast.net ([63.240.76.22])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EE9vX-0004kD-1M
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:18:13 -0700
From: Christopher Faylor <me@cgf.cx>
Subject: Re: [uml-devel] NPTL status?
Message-ID: <20050910181804.GA20544@trixie.casa.cgf.cx>
References: <20050909162442.GA11934@trixie.casa.cgf.cx>
	<200509101619.38922.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509101619.38922.blaisorblade@yahoo.it>
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
Date: Sat, 10 Sep 2005 14:18:04 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Sep 10, 2005 at 04:19:38PM +0200, Blaisorblade wrote:
>On Friday 09 September 2005 18:24, Christopher Faylor wrote:
>>As I understand it NPTL support in UML is still a work in progress.  Is
>>this correct?  If so, is there an experimental patch set which works
>>better with NPTL
>
>Yes, but I'd really underline _experimental_.

Understood.

>>and might allow things like RHEL4 to boot out-of-the-box?
>Basically, no.  At least nothing you'd rely onto.  There is something
>like that, but it doesn't work very well yet.
>
>If you browse my website, in the patches directory:
>
>http://www.user-mode-linux.org/~blaisorblade/patches/devel-guest/
>
>there are some test trees which include TLS support code.

Yes, apologies for not mentioning that I'd already looked in the
archives and tried those patches.  I don't know why I didn't think to
mention that.  IIRC, I wasn't able to completely boot RHEL4 with those,
unfortunately.  That's really my goal.  I can provide more details, if
it would help.

I saw that you were working on this and hoped that there might be newer
versions of these patches.  The newest one in the above directory is
31-Jul-2005.

cgf


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
