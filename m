Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CCiNR-0002Bb-OI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Sep 2004 10:36:29 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CCiNR-0006PK-1F for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Sep 2004 10:36:29 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] (no subject)
References: <8B6FF516CBA0194AB0996705076B02520F7C3C@ABGEX01E.abg.fsc.net>
In-Reply-To: <8B6FF516CBA0194AB0996705076B02520F7C3C@ABGEX01E.abg.fsc.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409291933.48271.blaisorblade_spam@yahoo.it>
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
Date: Wed, 29 Sep 2004 19:33:48 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Monday 27 September 2004 11:20, Stroesser, Bodo wrote:
> On Saturday 25 September 2004 21:35, BlaisorBlade wrote:
> > ...
> > This particular part is Ok, but could you, please, avoid trumpling
>
> over and removing the sysemu code? It's absolutely not needed.
>
> > If you enclose the last two ptrace calls in "if (!use_sysemu)" and you
>
> move the "handle_syscall" after them, you get your fix + no change for
> sysemu.
> Sorry. I didn't intend to break sysemu! Did I miss something or does it
> come from my confusing mail format?
> Here is the code of handle_trap() after applying the patch:
Ah, ok. Please accept my excuses, I didn't read well the patch (was I too 
tired?). However ok, it is correct, and the code is written this way in 
2.6.9-rc2, in fact, as with the original sysemu patch - the problem was in 
some little changes done by Jeff in his tree.


> > ...
> > A side note: posting HTML messages is bad (on LKML it is enough to be
>
> totally & completely ignored, I guess); and the above is what the inline
> patch becomes while answering to an HTML message - could you please
> either send plain-text or move the patches to attachments (I strongly
> prefer the first solution)?

> OK. Thank you for the advice. Unfortunately I'm missing experience in
> writing to mailing lists. And I have to do it with our companies Outlook
> client...
> In the meantime I found a switch to modify the settings to "text only".
> Hope it's better now?

Ok, that's perfect!
If you want to get advices on such questions, you may want to take a look at 
the LKML FAQ:

http://www.tux.org/lkml/
(The only important question I remember is "when/why to send the patch 
inline/attached/send an URL from the Web").

And these two documents about patch submission format:

http://linux.yyz.us/patch-format.html
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
(Note: when you find differences, do whatever you prefer; inserting the kernel 
version is a good idea, like the 1st doc says).

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
