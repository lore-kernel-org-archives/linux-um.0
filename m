Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fQA3m-0007Wg-4B
 for linux-um@lists.infradead.org; Tue, 05 Jun 2018 11:23:32 +0000
Date: Tue, 5 Jun 2018 14:22:54 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Fix initialization of vector queues in UML
Message-ID: <20180605112254.gsbkecaiqiyfniqc@mwanda>
References: <20180605082730.30919-1-anton.ivanov@cambridgegreys.com>
 <20180605084355.se5krnea6wrdmmez@mwanda>
 <bb4ec858-6dce-abf9-6ed3-cf654fedad92@cambridgegreys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bb4ec858-6dce-abf9-6ed3-cf654fedad92@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: richard.weinberger@gmail.com, linux-um@lists.infradead.org

On Tue, Jun 05, 2018 at 12:13:50PM +0100, Anton Ivanov wrote:
> =

> =

> On 06/05/18 09:43, Dan Carpenter wrote:
> > That's a good start but there are still issues:
> > =

> >     473          /* deallocate matching IOV structures including header=
 buffs */
> >     474          if (qi->mmsg_vector !=3D NULL) {
> >     475                  mmsg_vector =3D qi->mmsg_vector;
> >     476                  for (i =3D 0; i < qi->max_depth; i++) {
> >     477                          iov =3D mmsg_vector->msg_hdr.msg_iov;
> >     478                          if (iov !=3D NULL) {
> >     479                                  if ((vp->header_size > 0) &&
> >     480                                          (iov->iov_base !=3D NU=
LL))
> >     481                                          kfree(iov->iov_base);
> >     482                                  kfree(iov);
> >     483                          }
> >     484                          mmsg_vector++;
> >     485                  }
> >     486                  kfree(qi->mmsg_vector);
> >     487          }
> > =

> > =

> > mmsg_vector is a pointer to within the result->mmsg_vector array.  It
> > starts at the begining and iterates through the whole array.  The
> > problem is that we maybe didn't initialize the last half of the array so
> > now iov is pointing to random memory.
> =

> That array is initialized at lines 522-529=A0 for all elements
> unconditionally.
>

Oh, yeah.  You're right.

regards,
dan carpenter


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

