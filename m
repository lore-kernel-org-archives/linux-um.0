Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Al6Mn-0007je-An for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jan 2004 05:01:25 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1Al6Mm-0002VX-Qt
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jan 2004 05:01:25 -0800
From: Dan Shearer <dan@shearer.org>
Message-ID: <20040126130339.GN4536@erizo.shearer.org>
References: <20040126124708.GH4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20040126124708.GH4203@erizo.shearer.org>
Subject: [uml-devel] Re: PATCH kernel/umid.c
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
Date: Mon, 26 Jan 2004 23:33:39 +1030
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

In addition, umid.c seems to be a bit inconsistent as to what rates an
exit(1) and what just does return(1).

On Mon, Jan 26, 2004 at 11:17:08PM +1030, Dan Shearer wrote:
> --- umid.c.orig 2004-01-26 23:10:38.000000000 +1030
> +++ umid.c      2004-01-26 23:11:41.000000000 +1030
> @@ -205,7 +205,7 @@
>                         printf("Failed to malloc uml_dir - error = %d\n",
>                                errno);
>                         uml_dir = name;
> -                       return(0);
> +                       return(1);
>                 }
>                 sprintf(uml_dir, "%s/", name);
>         }

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
