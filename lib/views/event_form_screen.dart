import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/event_viewmodel.dart';
import '../models/event.dart';
import 'package:uuid/uuid.dart';

class EventFormScreen extends StatefulWidget {
  final Event? event; // Si un événement est passé, c'est pour la modification

  EventFormScreen({this.event});

  @override
  _EventFormScreenState createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final _eventTypeController = TextEditingController();
  final _bannerImageController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    // Si un événement est passé (modification), pré-remplir les champs
    if (widget.event != null) {
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event!.description;
      _dateController.text = widget.event!.date.toString();
      _locationController.text = widget.event!.location;
      _eventTypeController.text = widget.event!.eventType;
      _bannerImageController.text = widget.event!.bannerImage;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    _eventTypeController.dispose();
    _bannerImageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString();
      });
    }
  }

 void _submitForm() {
  if (_formKey.currentState!.validate()) {
    final event = Event(
      id: widget.event?.id ?? Uuid().v4(), // Use existing ID for updates, generate new ID for creation
      title: _titleController.text,
      description: _descriptionController.text,
      date: DateTime.parse(_dateController.text),
      location: _locationController.text,
      participantsCount: widget.event?.participantsCount ?? 0, // Keep existing count for updates
      reviews: widget.event?.reviews ?? [], // Keep existing reviews for updates
      eventType: _eventTypeController.text,
      organizerId: '1', // Simulate organizer ID
      status: 'Planned', // Default status
      bannerImage: _bannerImageController.text,
    );

    final eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    if (widget.event == null) {
      // Create a new event
      eventViewModel.createEvent(event);
    } else {
      // Update an existing event
      eventViewModel.updateEvent(event);
    }

    Navigator.pop(context); // Return to the previous screen
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event == null ? 'Create Event' : 'Edit Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _eventTypeController,
                decoration: InputDecoration(labelText: 'Event Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the event type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bannerImageController,
                decoration: InputDecoration(labelText: 'Banner Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a banner image URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.event == null ? 'Create Event' : 'Update Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}