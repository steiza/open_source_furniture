Open Source Furniture
=====================

Ever want to build your own furniture, but weren't sure where to start? This project lets you generate instructions for a CNC machine so you can make kitchen chairs that fit you or your space exactly. Here are the steps:

#. Get the code (it's here, on GitHub). You'll also need make and `OpenSCAD <http://www.openscad.org/>`_.

#. (optional) Modify the code to customize the chair.

#. Run "make chair" to generate a rendered PNG of the chair, a 3D STL of the parts for exact dimensioning, or a 2D DXF for sending to a CAM program.

.. image:: https://raw.github.com/steiza/open_source_furniture/master/images/render.png
.. image:: https://raw.github.com/steiza/open_source_furniture/master/images/2d_parts.png

#. Use a CAM program (like PartWorks - need an open source option here!), enter the dimensions of your size of wood and describe the cuts to generate G-code.

.. image:: https://raw.github.com/steiza/open_source_furniture/master/images/partworks.png

#. Send G-code from CAM program to a CNC router. Maybe your local `hackerspace <http://www.allhandsactive.com/>`_ or `makerspace <http://maker-works.com/>`_ can help out.

.. image:: https://raw.github.com/steiza/open_source_furniture/master/images/shopbot.jpg

#. Trim, sand, glue, and finish your chair!

.. image:: https://raw.github.com/steiza/open_source_furniture/master/images/chair.jpg

License
-------
The SCAD files here are released under the
`MIT License <http://opensource.org/licenses/MIT>`_
