Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUVkL-0005jN-Rh for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 11:45:41 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CUVkI-0000mV-7O for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 11:45:41 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Bug report for UML in latest Linus 2.6-BK
	repository.
References: <1100612306.24599.37.camel@imp.csi.cam.ac.uk>
	<200411172056.iAHKu9Q3004642@ccure.user-mode-linux.org>
In-Reply-To: <200411172056.iAHKu9Q3004642@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411172043.35481.blaisorblade_spam@yahoo.it>
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
Date: Wed, 17 Nov 2004 20:43:34 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>, lkml <linux-kernel@vger.kernel.org>

On Wednesday 17 November 2004 21:56, Jeff Dike wrote:
> aia21@cam.ac.uk said:
> > I get millions of these on the UML guest as soon as I start UML
> > (.config is below), notably HIGHMEM is not enabled in the .config.
> > They only stop when I shutdown.
>
> The patch below fixes those for me.

>     Jeff

Ok, yes... copy_from_user has never been atomic, and I should have remembered 
that. Sorry (anyway I wasn't going to fix that).

One more thing learned, anyway.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
