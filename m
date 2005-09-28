Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKaaZ-00083C-6w	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 04:59:07 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EKaaW-0004tx-NN
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 04:59:07 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] problem with wxGTK-2.6.2 and TLS in suse uml
References: <cdefcbcf050927062142be6a7@mail.gmail.com>
In-Reply-To: <cdefcbcf050927062142be6a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281014.00084.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 10:13:59 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Muhammad Sajjad <msajjad@gmail.com>

On Tuesday 27 September 2005 15:21, Muhammad Sajjad wrote:
> Hi,

> I am not able to run an application which is useing wxGTK-2.6.2 libaray.
> when tls is enable (/lib/tls exist) then segmentation fault occured.
Known..
> If tls is disable (/lib/tls.disable) then following error occure while
> calling wxDialog method in the application.
Ok, it stops later, and while doing what?
> Cannot create anonymous event.
What is it doing? Could you try to strace the failing application, and search 
for ENOSYS in the output?
> System error code: [38].
ENOSYS
> Function not implemented
Ok, this could mean that somehow, in your distro (SuSE), wxGTK depends on the 
TLS libraries. But that is not very likely.


So, instead, which UML version are you using? It is possible that the above 
error is given by a completely different kernel functionality, which wasn't 
implemented at that time. So, please upgrade your UML to a recent version, 
probably 2.6.13-bs2 - there's even a bug in modify_ldt() causing it to return 
ENOSYS, which is fixed in my patchset.

If this doesn't work, and strace says the failing call is set_thread_area / 
get_thread_area, the solution would probably involve recompiling wxGTK 
(probably from the source RPM, to avoid dependency problems), after fixing 
the configuration...
> This problem became head ache for me. please help me.

> regards,
> Sajjad

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
