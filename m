Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By6Lt-00055L-Qf for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 03:10:29 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1By6Lr-0000jX-Uv for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 03:10:28 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Patch for arch/um/drivers/line.c to fix buffer error
References: <40DFB54D.5040109@easyco.com>
In-Reply-To: <40DFB54D.5040109@easyco.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408141849.09779.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Tue, 17 Aug 2004 21:50:35 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Doug Dumitru <doug@easyco.com>

Alle 08:06, luned=EC 28 giugno 2004, Doug Dumitru ha scritto:
> All,
>
> I have been fighting a buffering error when sending large amounts of
> data out pty devices from UML.  I have tried a couple of patches that
> did not really fix the problem (and were rightly rejected by the group),
> but have finally found the real bug.
>
> In /arch/um/drivers/line.c there is a function "buffer_data" that is
> responsible for storing data into the lines ring buffer.  The function
> is "supposed" to return the number of characters actually buffered.
> Unfortunately, in the case where the buffer wraps, the "len" variable is
> decremented by "end" before it is used as the return parameter.
>
> Here is a patch that fixes this.
>
> --- linux-2.4.26-um/arch/um/drivers/line.c      2004-06-28
> 01:46:21.000000000 -0400
> +++ linux-2.4.23-um/arch/um/drivers/line.c      2004-06-28
> 01:45:35.000000000 -0400
> @@ -72,9 +72,9 @@
>          else {
>                  memcpy(line->tail, buf, end);
>                  buf +=3D end;
> -               len -=3D end;
> -               memcpy(line->buffer, buf, len);
> -               line->tail =3D line->buffer + len;
> +               //len -=3D end;
> +               memcpy(line->buffer, buf, len - end );
> +               line->tail =3D line->buffer + len - end;
>          }
>
>          return(len);
Since it was not collected in 2.4.26-2um, I'm collecting it for my 2.4 and =
2.6=20
patchsets. I would like a test case for this, if possible (i.e. the patch=20
looks right, but I don't notice any problem on consoles, which are handled =
by=20
the same code).

> There is actually another bug in this area, but I am still working on a
> "good" fix for this.  The scenario is this:
>
>    o An application opens an output device (ie /dev/serial/13)
>    o It pushes stuff do the device
>    o It closes the device

> This would be like:
>
>    cat /etc/termcap > /dev/serial/13

Without DevFS it maps to cat /etc/termcap > /dev/ttyS0, right? I've just=20
checked that this *should* be true (there seems to be a UML-specific symlin=
k=20
from /dev/serial to /dev/tts).

> The problem is that the device will close while there is still data
> buffered in the ring buffer (and the ring-buffered data will not be
> transfered to the device).

Ehr, probably I don't understand you well, because it seems me that the fix=
=20
would be as easy as calling flush_buffer() during line_close(). Or not?

I guess that there are some synchronization issue (there is an interrupt do=
ing=20
the same thing, but it's disable in line_disable) - and there is some=20
refcount kludge commented about in line_close(). But that's the idea, right=
?=20
However, for now I didn't handle this thing. So please remind this me.

> This is a pretty complicated scenario to=20
> handle completely, so I have not tried to put together a patch for this
> (plus it does not directly impact my customers at this point).  In
> theory, handling all of these situations might require changes to how
> the ring-buffering is implemented (or maybe can the ring-buffer be
> eliminated all together).  Suggestions on how to implement this would be
> appreciated.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
