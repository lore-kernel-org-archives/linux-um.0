Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BayUq-0003Dq-DA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jun 2004 08:08:08 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BayUp-00083Q-66 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jun 2004 08:08:07 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [UML] Performance hit for setting CS segment limit
References: <200406111954.15283.blaisorblade_spam@yahoo.it>
	<20040615054545.GB2543@elte.hu>
In-Reply-To: <20040615054545.GB2543@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200406162141.57213.blaisorblade_spam@yahoo.it>
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
Date: Wed, 16 Jun 2004 21:41:57 +0200
Content-Transfer-Encoding: quoted-printable
To: Ingo Molnar <mingo@elte.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 07:45, marted=EC 15 giugno 2004, Ingo Molnar ha scritto:
> * BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
> > Hi Ingo, I need some help from you about the performance hit of
> > segmentation, which you probably studied for the exec-shield patch.
> >
> > In short: if I reduce the limit of the CS, DS and so on segment
> > descriptors (let's say it becomes 2,5G instead of 4G), a bit like you
> > do in the exec-shield patch, will this setting impact on the
> > performance of the process, apart for the time to set them? I also
> > assume that segment changes do not flush the TLBs; is this correct?
> >
> > I've been told by Jeff Dike (you can check on the ML) that :
> >
> > "This is slow, plus ****using segments will cost you a cycle or
> > something on EVERY memory reference***. Alan Cox warned me off very
> > strongly against doing this.", though maybe he referred to something
> > different: is this true in this case?
>
> this might be true for _data_ segments

Well, sadly I need to know for those also... however I'm going to search=20
myself.

>, but not for the code segment.
> The code segment limit can be checked when an iTLB miss occurs

And so iTLB means instruction TLB, right? (I was wondering about this in yo=
ur=20
discussion about 4G/4G patch with Andrea Arcangeli).

Also, from some tests, I would guess that also for Celeron, and not only fo=
r=20
Xeon, there are at least 64 dTLB. Is this correct? I used this to explain=20
some benchmark datas.

I noticed that when touching more than 64 different pages (i.e. 512 in my=20
test), flushing or not the TLBs gave almost no "secondary cost" for reloadi=
ng=20
them when re-touching those pages, while the secondary cost was very high=20
with 64 pages.

>, no need
> to check during code prefetch itself. So there's no overhead.

The only difference, here, is that for data segments, which are also import=
ant=20
here, on a dTLB (i.e. I guess dTLB =3D data TLB) fault the check is done fo=
r a=20
certain segment, so it could have a little overhead (though Intel claims it=
=20
is done in parallel with address translation, in their manuals).

Thanks a lot!
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
