Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AlfDw-00070M-9b for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 18:14:36 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1AlfDv-0005od-R2
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 18:14:36 -0800
From: Dan Shearer <dan@shearer.org>
Subject: Re: [uml-devel] Re: [PATCH] mconsole fixes
Message-ID: <20040128021652.GP4203@erizo.shearer.org>
References: <20040126024617.GB4203@erizo.shearer.org>
	<200401280146.i0S1kaZw004957@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200401280146.i0S1kaZw004957@ccure.user-mode-linux.org>
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
Date: Wed, 28 Jan 2004 12:46:52 +1030
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Jan 27, 2004 at 08:46:36PM -0500, Jeff Dike wrote:
 
> > -    fprintf(stderr, "Sending command to '%s' : ", sun.sun_path);
> > -    perror("");
> > -    return;
> > +    if (strlen(sun.sun_path)==0) {
> > +      fprintf(stderr, "No connection exists, cannot send command.\n");
> > +    } else {
> > +      fprintf(stderr, "While sending command to '%s' : ", sun.sun_path);
> > +      perror("");
> > +    }
> > +    return(1);
> 
> I don't see the point of the strlen(sun.sun_path)==0 check, so I'm
> leaving that out until I see why it's necessary.

My idea was that there's a difference between an error on a connection
and no connection at all. Having no connection at all can happen very
easily, especially if you happen to use uml_dir on the cmdline which
triggers a bug that puts the file in the wrong place.

> I applied most of the rest of that.  I got rid of the exits from main, since
> I like returns better and I tidied up some other stuff.

Minor portability potential. See
http://www.eskimo.com/~scs/C-faq/q11.16.html. (I looked it up once long
ago and supposedly _exit is more likely to work on more systems than
exit.)

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
