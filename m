Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Alh7B-0006Uj-Sy for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:15:45 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Alh7B-0007wQ-8N
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:15:45 -0800
Message-Id: <200401280439.i0S4dfZw005542@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: [PATCH] mconsole fixes 
In-Reply-To: Your message of "Wed, 28 Jan 2004 12:46:52 +1030."
	<20040128021652.GP4203@erizo.shearer.org> 
References: <20040126024617.GB4203@erizo.shearer.org>
	<200401280146.i0S1kaZw004957@ccure.user-mode-linux.org>
	<20040128021652.GP4203@erizo.shearer.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 27 Jan 2004 23:39:41 -0500
To: Dan Shearer <dan@shearer.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

dan@shearer.org said:
> My idea was that there's a difference between an error on a connection
> and no connection at all. Having no connection at all can happen very
> easily, especially if you happen to use uml_dir on the cmdline which
> triggers a bug that puts the file in the wrong place. 

OK, that being the case, it's better to complain before sending anything to
UML rather than after you've tried and failed.

> Minor portability potential. See http://www.eskimo.com/~scs/C-faq/
> q11.16.html. (I looked it up once long ago and supposedly _exit is
> more likely to work on more systems than exit.) 

You talked me into it.  I fixed that.

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
