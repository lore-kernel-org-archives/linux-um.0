Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlePw-0004Cz-Lo for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 17:22:56 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AlePw-0006tp-3S
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 17:22:56 -0800
Message-Id: <200401280146.i0S1kaZw004957@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Mon, 26 Jan 2004 13:16:17 +1030."
	<20040126024617.GB4203@erizo.shearer.org> 
References: <20040126024617.GB4203@erizo.shearer.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [PATCH] mconsole fixes
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
Date: Tue, 27 Jan 2004 20:46:36 -0500
To: Dan Shearer <dan@shearer.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

dan@shearer.org said:
> + * instance over a local pipe connection. This tool does not 
> + * (since uml_mconsole version 1) need to be in sync with the version
> + * of the UML kernel since the commands and their implementation 
> + * are within UML.

The version does need to match.  UML will only talk to one version of mconsole.

The smarts are all in the kernel, but they do need to agree on the format of
the request and the response.

> -    fprintf(stderr, "Sending command to '%s' : ", sun.sun_path);
> -    perror("");
> -    return;
> +    if (strlen(sun.sun_path)==0) {
> +      fprintf(stderr, "No connection exists, cannot send command.\n");
> +    } else {
> +      fprintf(stderr, "While sending command to '%s' : ", sun.sun_path);
> +      perror("");
> +    }
> +    return(1);

I don't see the point of the strlen(sun.sun_path)==0 check, so I'm leaving that
out until I see why it's necessary.

I applied most of the rest of that.  I got rid of the exits from main, since
I like returns better and I tidied up some other stuff.

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
