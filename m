Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUr5f-0002I4-KA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 10:33:07 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CUr5e-0003Tg-FT for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 10:33:07 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <20041118160909.GA7630@halcrow.us>
In-Reply-To: <20041118160909.GA7630@halcrow.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411181839.26596.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] keyring syscalls
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
Date: Thu, 18 Nov 2004 18:39:26 +0100
To: Michael Halcrow <uml@halcrow.us>, user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

On Thursday 18 November 2004 17:09, Michael Halcrow wrote:
> Howdy folks,
>
> I am attempting to use David Howells' new keyring in 2.6.10-rc2 UML
> and am getting a ``Function not implemented'' error with keyctl.  I
> was getting that in my host kernel until I mucked with the __NR_*
> #define's in the userspace keyctl.c to align with the values in the
> 2.6.10-rc2 entry.S.  I imagine that new syscalls require some magic in
> UML that I am unfamiliar with.  I tried adding some entries to
> arch/um/include/sysdep-i386/syscalls.h for keyctl et. al., to no
> avail, but I'm kind of shooting the dark here.
>
> Thanks,
> Mike
Ok, please list the new syscalls - I see at least add_key() and request_key() 
too - are these three the only ones? I'll build the patch ASAP when getting 
your answer.
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
