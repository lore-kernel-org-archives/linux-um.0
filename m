MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20150120121100.28406.95201.stgit@localhost.localdomain>
References: <20150120121100.28406.95201.stgit@localhost.localdomain>
Date: Tue, 20 Jan 2015 13:24:41 +0100
Message-ID: <CAMuHMdW9MDTMZEN7paytQm+7-6sY_qTHOWQ9KY0ooaggyU8n=w@mail.gmail.com>
Subject: Re: [PATCH RESEND] um,ethertap: use strncpy
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Alan <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <greg@kroah.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Jan 20, 2015 at 1:11 PM, Alan <gnomes@lxorguk.ukuu.org.uk> wrote:
> I can't prove the case pointed out in
> https://bugzilla.kernel.org/show_bug.cgi?id=82341
> is correct so let us play safe.
>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>  arch/um/os-Linux/drivers/ethertap_user.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
> index b39b669..6d49182 100644
> --- a/arch/um/os-Linux/drivers/ethertap_user.c
> +++ b/arch/um/os-Linux/drivers/ethertap_user.c
> @@ -105,7 +105,7 @@ static int etap_tramp(char *dev, char *gate, int control_me,
>         sprintf(data_fd_buf, "%d", data_remote);
>         sprintf(version_buf, "%d", UML_NET_VERSION);

The two above may also overflow, if the numbers contain more than 5
resp. 6 digits.

>         if (gate != NULL) {
> -               strcpy(gate_buf, gate);
> +               strncpy(gate_buf, gate, 15);

Same comment as before:

"This will copy at most 15 bytes.
 If "gate" contains 15 or more characters, gate_buf[] won't be
 zero-terminated.
 I think you better use strlcpy(), unless the remaining of the buffer
 must be filled with zeroes."

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

