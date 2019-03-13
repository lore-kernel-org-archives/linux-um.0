Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190312133047.16201-1-brgl@bgdev.pl> <56704758-ee74-0e9b-de1c-1dc94deda8d7@cambridgegreys.com>
In-Reply-To: <56704758-ee74-0e9b-de1c-1dc94deda8d7@cambridgegreys.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 13 Mar 2019 10:48:25 +0100
Message-ID: <CAMRc=MdRKvM8ug_KNcwUGHv9J6OLFa1o_WaCbebxWUGyGVZtiw@mail.gmail.com>
Subject: Re: [PATCH] um: remove uses of variable length arrays
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

=C5=9Br., 13 mar 2019 o 10:45 Anton Ivanov
<anton.ivanov@cambridgegreys.com> napisa=C5=82(a):
>
> On 12/03/2019 13:30, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > While the affected code is run in user-mode, the build still warns
> > about it. Convert all uses of VLA to dynamic allocations.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   arch/um/os-Linux/umid.c | 36 +++++++++++++++++++++++++++---------
> >   1 file changed, 27 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
> > index 998fbb445458..e261656fe9d7 100644
> > --- a/arch/um/os-Linux/umid.c
> > +++ b/arch/um/os-Linux/umid.c
> > @@ -135,12 +135,18 @@ static int remove_files_and_dir(char *dir)
> >    */
> >   static inline int is_umdir_used(char *dir)
> >   {
> > -     char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
> > -     char pid[sizeof("nnnnn\0")], *end;
> > +     char pid[sizeof("nnnnn\0")], *end, *file;
> >       int dead, fd, p, n, err;
> > +     size_t filelen;
> >
> > -     n =3D snprintf(file, sizeof(file), "%s/pid", dir);
> > -     if (n >=3D sizeof(file)) {
> > +     err =3D asprintf(&file, "%s/pid", dir);
> > +     if (err < 0)
> > +             return 0;
> > +
> > +     filelen =3D strlen(file);
> > +
> > +     n =3D snprintf(file, filelen, "%s/pid", dir);
> > +     if (n >=3D filelen) {
> >               printk(UM_KERN_ERR "is_umdir_used - pid filename too long=
\n");
> >               err =3D -E2BIG;
> >               goto out;
> > @@ -185,6 +191,7 @@ static inline int is_umdir_used(char *dir)
> >   out_close:
> >       close(fd);
> >   out:
> > +     free(file);
> >       return 0;
> >   }
> >
> > @@ -210,18 +217,21 @@ static int umdir_take_if_dead(char *dir)
> >
> >   static void __init create_pid_file(void)
> >   {
> > -     char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
> > -     char pid[sizeof("nnnnn\0")];
> > +     char pid[sizeof("nnnnn\0")], *file;
> >       int fd, n;
> >
> > -     if (umid_file_name("pid", file, sizeof(file)))
> > +     file =3D malloc(strlen(uml_dir) + UMID_LEN + sizeof("/pid\0"));
> > +     if (!file)
> >               return;
> >
> > +     if (umid_file_name("pid", file, sizeof(file)))
> > +             goto out;
> > +
> >       fd =3D open(file, O_RDWR | O_CREAT | O_EXCL, 0644);
> >       if (fd < 0) {
> >               printk(UM_KERN_ERR "Open of machine pid file \"%s\" faile=
d: "
> >                      "%s\n", file, strerror(errno));
> > -             return;
> > +             goto out;
> >       }
> >
> >       snprintf(pid, sizeof(pid), "%d\n", getpid());
> > @@ -231,6 +241,8 @@ static void __init create_pid_file(void)
> >                      errno);
> >
> >       close(fd);
> > +out:
> > +     free(file);
> >   }
> >
> >   int __init set_umid(char *name)
> > @@ -385,13 +397,19 @@ __uml_setup("uml_dir=3D", set_uml_dir,
> >
> >   static void remove_umid_dir(void)
> >   {
> > -     char dir[strlen(uml_dir) + UMID_LEN + 1], err;
> > +     char *dir, err;
> > +
> > +     dir =3D malloc(strlen(uml_dir) + UMID_LEN + 1);
> > +     if (!dir)
> > +             return;
> >
> >       sprintf(dir, "%s%s", uml_dir, umid);
> >       err =3D remove_files_and_dir(dir);
> >       if (err)
> >               os_warn("%s - remove_files_and_dir failed with err =3D %d=
\n",
> >                       __func__, err);
> > +
> > +     free(dir);
> >   }
> >
> >   __uml_exitcall(remove_umid_dir);
> >
>
> Thanks for bringing it up. It helped me notice that this is actually brok=
en.
>
> PID can be more than 5 digits nowdays.
>

Do we have a macro in the kernel that yields the minimum size of an
array to fit a number? I can't find it. I vagely remember seeing
something like this in systemd tree. If it doesn't exist in the kernel
then maybe we should copy it over.

Bart

