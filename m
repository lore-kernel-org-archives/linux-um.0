Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWCgc-0007am-Ix	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 04:53:22 -0800
Received: from zproxy.gmail.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EWCgb-0006Hh-Ck
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 04:53:22 -0800
Received: by zproxy.gmail.com with SMTP id x7so442342nzc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 30 Oct 2005 04:53:00 -0800 (PST)
Message-ID: <35fb2e590510300453q520a9ce7ua1d74d7790b3a6b8@mail.gmail.com>
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
In-Reply-To: <200510300624.38794.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
References: <200510300624.38794.rob@landley.net>
Subject: [uml-devel] Re: What's wrong with tmpfs?
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
Date: Sun, 30 Oct 2005 12:53:00 +0000
Content-Transfer-Encoding: 8bit
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On 10/30/05, Rob Landley <rob@landley.net> wrote:

> If somebody needs a reproduction sequence, I'm happy to oblige.  In theory
> "mount -t tmpfs /mnt /mnt" should do it, but if it was _that_ simple it
> wouldn't have shipped...

I don't see this behaviour on a regular desktop box running 2.6.14.
Guess it's UML specific.

Jon.


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
