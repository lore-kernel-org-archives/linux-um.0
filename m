Return-Path: <greg@kroah.com>
Date: Mon, 4 Jan 2010 14:39:17 -0800
From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [uml-devel] linux-2.6.32 uml Segmentation fault
Message-ID: <20100104223917.GB20708@kroah.com>
References: <1261222401.435.6.camel@localhost>
 <10f740e80912200107v4ffeee81k77e291ffaebac837@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <10f740e80912200107v4ffeee81k77e291ffaebac837@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: clownix <clownix@clownix.net>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, stable <stable@kernel.org>, uml-user <user-mode-linux-user@lists.sourceforge.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Dec 20, 2009 at 10:07:03AM +0100, Geert Uytterhoeven wrote:
> On Sat, Dec 19, 2009 at 12:33, clownix <clownix@clownix.net> wrote:
> > Hello
> > For the 2.6.32 kernel there are 2 problems:
> >
> > 1: Compile error, this patch works for it:
> > --------------------------------------------
> >
> > diff -Naur old_linux-2.6.32.1/security/keys/keyctl.c
> > linux-2.6.32.1/security/keys/keyctl.c
> > --- old_linux-2.6.32.1/security/keys/keyctl.c =EF=BF=BD 2009-12-14
> > 18:47:25.000000000 +0100
> > +++ linux-2.6.32.1/security/keys/keyctl.c =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 2009-12-15 22:40:32.565286766
> > +0100
> > @@ -1236,6 +1236,7 @@
> > =EF=BF=BD*/
> > =EF=BF=BDlong keyctl_session_to_parent(void)
> > =EF=BF=BD{
> > +#ifdef TIF_NOTIFY_RESUME
> > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDstruct task_struct *me, *parent;
> > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDconst struct cred *mycred, *pcre=
d;
> > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDstruct cred *cred, *oldcred;
> > @@ -1326,6 +1327,9 @@
> > =EF=BF=BDerror_keyring:
> > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDkey_ref_put(keyring_r);
> > =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDreturn ret;
> > +#else /* !TIF_NOTIFY_RESUME */
> > + =EF=BF=BD =EF=BF=BD =EF=BF=BD return -EOPNOTSUPP;
> > +#endif /* !TIF_NOTIFY_RESUME */
> > =EF=BF=BD}
>=20
> Aha, UML is also affected.
>=20
> Commit a00ae4d21b2fa9379914f270ffffd8d3bec55430 ("Keys:
> KEYCTL_SESSION_TO_PARENT needs TIF_NOTIFY_RESUME architecture
> support") should be in 2.6.32-stable as it fixes a regression, but
> apparently the `Cc: stable@kernel.org' got lost?

Now queued up, thanks for letting me know.

greg k-h

