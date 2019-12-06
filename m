Return-Path: <arnd@arndb.de>
MIME-Version: 1.0
References: <3820d68b-1d97-8f41-d55d-237d1695458c@cambridgegreys.com>
 <CAMuHMdWuiGC4ay=f6M2H=-PLiffavnFSu8CPXE26euAi6aoY0w@mail.gmail.com>
 <CAK8P3a1mrFgRyh5Fgv-d8Szd2pq0T6Ac7wL3ogeYcf-Uyrg4ZQ@mail.gmail.com>
 <a5b9709d-b93b-46e1-ab18-a94ab921ccf7@cambridgegreys.com> <9dc1be66-5c55-8b3d-875b-4e1206914e78@cambridgegreys.com>
In-Reply-To: <9dc1be66-5c55-8b3d-875b-4e1206914e78@cambridgegreys.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 6 Dec 2019 21:06:45 +0100
Message-ID: <CAK8P3a1KcRcpUB2PdA17tnHN_dDs2Y02zPtkgM22Z-JdugAkfQ@mail.gmail.com>
Subject: Re: 64 bit time regression in recvmmsg()
Content-Type: text/plain; charset="UTF-8"
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Fri, Dec 6, 2019 at 6:50 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
> On 29/11/2019 16:34, Anton Ivanov wrote:
>
> I apologize, problem elsewhere. I have narrowed it down, it is a host
> regression at the end, not a recvmmsg/time one.
>
> The EINVAL is occasionally returned from the guts of packet_rcv_vnet
>
> https://elixir.bootlin.com/linux/latest/ident/packet_rcv_vnet
>
> in af_packet. I am going to try to figure out exactly when it happens
> and why.
>
> My sincere apologies,

No, worries, I'm glad it wasn't me this time ;-)

     Arnd

